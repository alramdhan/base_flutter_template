part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

/// Belum ada aksi apapun (state awal sebelum BLoC pertama kali dipakai).
class ProductInitial extends ProductState {}

/// Loading pertama kali (grid masih kosong, tampilkan skeleton/spinner penuh).
class ProductLoading extends ProductState {}

/// Data berhasil dimuat. `isLoadingMore` dipakai untuk menampilkan
/// spinner kecil di bawah grid saat infinite scroll sedang ambil halaman baru.
class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;
  final String? searchKeyword;
  final int? categoryId;

  const ProductLoaded({
    required this.products,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    required this.currentPage,
    this.searchKeyword,
    this.categoryId,
  });

  ProductLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
    String? searchKeyword,
    int? categoryId,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
    products,
    hasReachedMax,
    isLoadingMore,
    currentPage,
    searchKeyword,
    categoryId,
  ];
}

/// Gagal memuat data — UI menampilkan pesan error + tombol "Coba Lagi".
class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}