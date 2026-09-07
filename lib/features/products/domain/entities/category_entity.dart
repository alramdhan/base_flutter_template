import 'package:equatable/equatable.dart';

/// Entity murni untuk kategori produk. Tidak tahu soal JSON/API —
/// itu tanggung jawab layer data (CategoryModel).
class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? slug;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.slug
  });

  @override
  List<Object?> get props => [id, name, slug];
}