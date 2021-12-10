import 'package:domain/src/entities/entities.dart';
import 'package:meta/meta.dart';

/// {@template domain.offer}
/// The offer domain entity.
/// {@endtemplate}
@immutable
class Offer {
  /// {@macro domain.offer}
  const Offer({
    required this.id,
    required this.price,
    required this.product,
  }) : assert(price >= 0, 'Price must be greater than or equal to 0.');

  /// The unique identifier of the offer.
  final String id;

  /// The price of the offer.
  final int price;

  ///// The product of the offer.
  final Product product;

  @override
  String toString() => 'Offer(id: $id, price: $price, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Offer &&
        other.id == id &&
        other.price == price &&
        other.product == product;
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ id.hashCode ^ price.hashCode ^ product.hashCode;
}
