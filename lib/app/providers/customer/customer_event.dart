part of 'customer_bloc.dart';

abstract class CustomerEvent {
  const CustomerEvent._();
}

class Initialized extends CustomerEvent {
  const Initialized({this.force = false}) : super._();

  final bool force;

  @override
  String toString() {
    return [
      'Initialized(',
      if (force) 'force: $force',
      ')',
    ].join();
  }
}

class OfferPurchased extends CustomerEvent {
  const OfferPurchased(this.offerId) : super._();

  final String offerId;

  @override
  String toString() {
    return 'OfferPurchased(offerId: $offerId)';
  }
}
