import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/products/domain/usecases/get_categories.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/category_state.dart';

/// Cubit dipilih (bukan Bloc) karena flow-nya sederhana: fetch sekali,
/// lalu user tinggal pilih salah satu chip kategori. Tidak ada kebutuhan
/// search/debounce/pagination seperti di ProductBloc.
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategories;

  CategoryCubit({required this.getCategories}) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());

    final result = await getCategories(const NoParams());

    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }

  /// Dipanggil saat user tap salah satu chip kategori.
  /// Tidak fetch ulang ke API — cukup update kategori mana yang aktif,
  /// lalu UI (Home/ProductListPage) yang mendengarkan perubahan ini
  /// men-trigger ProductBloc untuk fetch ulang produk dengan filter baru.
  void selectCategory(int? categoryId) {
    final current = state;
    if (current is! CategoryLoaded) return;

    emit(
      categoryId == null
        ? current.copyWith(clearSelected: true)
        : current.copyWith(selectedCategoryId: categoryId),
    );
  }
}