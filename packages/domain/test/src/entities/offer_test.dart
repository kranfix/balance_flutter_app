import 'package:domain/domain.dart';
import 'package:test/test.dart';

Offer offerGenerato(String id, {int? price}) {
  return Offer(
    id: id,
    price: price ?? 23,
    product: const Product(
      id: 'id',
      name: 'name',
      description: 'description',
      image: 'imageUrl',
    ),
  );
}

void main() {
  test('offer to string', () {
    const offer = Offer(
      id: 'id',
      price: 23,
      product: Product(
        id: 'id',
        name: 'name',
        description: 'description',
        image: 'imageUrl',
      ),
    );
    expect(
      offer.toString(),
      'Offer(id: id, price: 23, product: ${offer.product})',
    );
  });

  test('offer equality', () {
    final offer1 = offerGenerato('id1');
    final offer2 = offerGenerato('id1');

    expect(offer1, equals(offer2));
    expect(offer1.hashCode, equals(offer2.hashCode));
    expect(offer1, isNot(same(offer2)));
  });

  test('offer inequality', () {
    final offer1 = offerGenerato('id1');
    final offer2 = offerGenerato('id2');

    expect(offer1, isNot(equals(offer2)));
    expect(offer1.hashCode, isNot(equals(offer2.hashCode)));
  });

  test('offer can not have a negative price', () {
    expect(
      () => offerGenerato('id1', price: -1),
      throwsA(isA<AssertionError>()),
    );
  });
}
