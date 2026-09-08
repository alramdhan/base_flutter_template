import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';
import 'package:login_biometrics_app/features/products/domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

const _searchDebounceDuration = Duration(milliseconds: 400);
const _perPage = 15;

/// Transformer agar setiap event baru membatalkan proses event sebelumnya
/// yang belum selesai (mencegah race condition saat user scroll cepat
/// atau mengetik cepat di search bar).
EventTransformer<E> _restartable<E>() {
  return (events, mapper) => events.switchMap(mapper);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts, transformer: _restartable());
    on<RefreshProducts>(_onRefreshProducts, transformer: _restartable());
    on<FetchNextProductPage>(_onFetchNextPage, transformer: _restartable());
    on<FilterProductsByCategory>(_onFilterByCategory, transformer: _restartable());

    // Debounce khusus search supaya tidak fetch API di setiap ketikan.
    on<SearchProducts>(
      _onSearchProducts,
      transformer: (events, mapper) => events.debounce(_searchDebounceDuration).switchMap(mapper),
    );
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await _fetchAndEmit(page: 1, emit: emit);
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    // Sengaja tidak emit ProductLoading agar grid lama tetap terlihat
    // saat pull-to-refresh (indikator refresh sudah cukup dari RefreshIndicator).
    final current = state;
    await _fetchAndEmit(
      page: 1,
      emit: emit,
      search: current is ProductLoaded ? current.searchKeyword : null,
      categoryId: current is ProductLoaded ? current.categoryId : null,
    );
  }

  Future<void> _onFetchNextPage(
    FetchNextProductPage event,
    Emitter<ProductState> emit,
  ) async {
    final current = state;
    if (current is! ProductLoaded ||
        current.hasReachedMax ||
        current.isLoadingMore) {
      return; // Tidak ada halaman lagi atau sedang loading, tidak perlu fetch.
    }

    emit(current.copyWith(isLoadingMore: true));

    final result = await getProducts(GetProductsParams(
      page: current.currentPage + 1,
      perPage: _perPage,
      search: current.searchKeyword,
      categoryId: current.categoryId,
    ));

    result.fold(
      (failure) => emit(current.copyWith(isLoadingMore: false)),
      (page) => emit(current.copyWith(
        products: [...current.products, ...page.products],
        hasReachedMax: page.hasReachedMax,
        isLoadingMore: false,
        currentPage: page.currentPage,
      )),
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    final current = state;
    emit(ProductLoading());
    await _fetchAndEmit(
      page: 1,
      emit: emit,
      search: event.keyword,
      categoryId: current is ProductLoaded ? current.categoryId : null,
    );
  }

  Future<void> _onFilterByCategory(
    FilterProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    final current = state;
    emit(ProductLoading());
    await _fetchAndEmit(
      page: 1,
      emit: emit,
      search: current is ProductLoaded ? current.searchKeyword : null,
      categoryId: event.categoryId,
    );
  }

  Future<void> _fetchAndEmit({
    required int page,
    required Emitter<ProductState> emit,
    String? search,
    int? categoryId,
  }) async {
    final result = await getProducts(GetProductsParams(
      page: page,
      perPage: _perPage,
      search: search,
      categoryId: categoryId,
    ));

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (pageResult) => emit(ProductLoaded(
        products: pageResult.products,
        hasReachedMax: pageResult.hasReachedMax,
        currentPage: pageResult.currentPage,
        searchKeyword: search,
        categoryId: categoryId,
      )),
    );
  }
}