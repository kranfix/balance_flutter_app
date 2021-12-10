/// Exception base clase for purchase.
abstract class PurchaseOfferException implements Exception {}

/// {@template domain.PurchaseOfferForbidenException}
/// Exception for forbiden purchase.
/// {@endtemplate}
class PurchaseOfferForbidenException implements PurchaseOfferException {
  /// {@macro domain.PurchaseOfferForbidenException}
  const PurchaseOfferForbidenException(this.offerId);

  /// The offer id that was not allowed to be purchased.
  final String offerId;

  @override
  String toString() => 'PurchaseOfferForbidenException(offerId: $offerId)';
}
