import 'package:domain/src/offer/offer_exceptions.dart';
import 'package:test/test.dart';

void main() {
  test('offer exceptions ...', () {
    const exception = PurchaseOfferForbidenException('offerId1');
    expect(
      exception.toString(),
      'PurchaseOfferForbidenException(offerId: offerId1)',
    );
  });
}
