import 'package:meta/meta.dart';

/// {@template domain.product}
/// Product domain entity.
/// {@endtemplate}
@immutable
class Product {
  /// {@macro domain.product}
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  /// [Product] `ID`
  final String id;

  /// [Product] `name`
  final String name;

  /// [Product] `description`
  final String description;

  /// `image` url of the product.
  final String image;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, '
        'image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
