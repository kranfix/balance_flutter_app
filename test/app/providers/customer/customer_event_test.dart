import 'package:nubank_flutter_challenge/app/providers/customer.dart';
import 'package:test/test.dart';

void main() {
  test('customer initialized event to string', () {
    const initilized = Initialized();
    expect(
      initilized.toString(),
      'Initialized()',
    );

    const restarted = Initialized(force: true);
    expect(
      restarted.toString(),
      'Initialized(force: true)',
    );
  });

  test('customer initialized event to json', () {
    const purchased = OfferPurchased('id1');
    expect(
      purchased.toString(),
      'OfferPurchased(offerId: id1)',
    );
  });
}
