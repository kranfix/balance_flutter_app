import 'package:collection/collection.dart';
import 'package:domain/src/entities/entities.dart';
import 'package:meta/meta.dart';

const _listEquals = ListEquality<Offer>();

/// {@template domain.customer}
/// Customer domain entity.
/// {@endtemplate}
@immutable
class Customer {
  /// {@macro domain.customer}
  const Customer({
    required this.id,
    required this.name,
    required this.balance,
    required this.offers,
  }) : assert(balance >= 0, 'Balance must be greater than or equal to 0.');

  /// `id` of the customer.
  final String id;

  /// `name` of the customer.
  final String name;

  /// `balance` of the customer.
  final int balance;

  /// `offers` for the customer.
  final List<Offer> offers;

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, balance: $balance, offers: $offers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.id == id &&
        other.name == name &&
        other.balance == balance &&
        _listEquals.equals(other.offers, offers);
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^
        id.hashCode ^
        name.hashCode ^
        balance.hashCode ^
        _listEquals.hash(offers);
  }
}
