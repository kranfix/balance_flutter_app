// ignore_for_file: one_member_abstracts
import 'package:domain/domain.dart';

/// Repository for handling offers
abstract class OfferRepo {
  /// Purchase an offer by id
  ///
  /// Throws [PurchaseOfferForbidenException] if the offer is not found
  Future<Customer> purchaseOne(String offerId);
}
