part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

/// Dipanggil saat halaman pertama kali dibuka.
class FetchProducts extends ProductEvent {
  const FetchProducts();
}

/// Dipanggil saat user pull-to-refresh.
class RefreshProducts extends ProductEvent {
  const RefreshProducts();
}

/// Dipanggil saat user scroll mendekati akhir list (infinite scroll).
class FetchNextProductPage extends ProductEvent {
  const FetchNextProductPage();
}

/// Dipanggil saat user mengetik di search bar.
class SearchProducts extends ProductEvent {
  final String keyword;
  const SearchProducts(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

/// Dipanggil saat user memilih filter kategori (null = semua kategori).
class FilterProductsByCategory extends ProductEvent {
  final int? categoryId;
  const FilterProductsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}