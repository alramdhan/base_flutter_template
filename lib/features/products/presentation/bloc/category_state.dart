import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/products/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  final int? selectedCategoryId; // null = "Semua" sedang dipilih

  const CategoryLoaded({
    required this.categories,
    this.selectedCategoryId,
  });

  CategoryLoaded copyWith({int? selectedCategoryId, bool clearSelected = false}) {
    return CategoryLoaded(
      categories: categories,
      selectedCategoryId:
          clearSelected ? null : (selectedCategoryId ?? this.selectedCategoryId),
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategoryId];
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}