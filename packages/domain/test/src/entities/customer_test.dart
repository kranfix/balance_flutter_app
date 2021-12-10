import 'package:domain/domain.dart';
import 'package:test/test.dart';

Customer customerGenerator(String id) {
  return Customer(
    id: id,
    balance: 400,
    name: 'Frank',
    offers: [
      Offer(
        id: 'offer-$id-1',
        price: 100,
        product: Product(
          id: 'product-$id-1',
          name: 'Product 1 ($id)',
          description: 'Description 1 ($id)',
          image: 'image-$id-1',
        ),
      ),
      Offer(
        id: 'offer-$id-2',
        price: 120,
        product: Product(
          id: 'product-$id-2',
          name: 'Product 2 ($id)',
          description: 'Description 2 ($id)',
          image: 'image-$id-2',
        ),
      ),
    ],
  );
}

void main() {
  test('viewer to string', () {
    final customer = customerGenerator('id1');
    expect(
      customer.toString(),
      '''
Customer(id: id1, name: Frank, balance: 400, offers: ${customer.offers})''',
    );
  });

  test('Customer equality', () {
    final customer1 = customerGenerator('id1');
    final customer2 = customerGenerator('id1');
    expect(customer1, equals(customer2));
    expect(customer1.hashCode, equals(customer2.hashCode));
    expect(customer1, isNot(same(customer2)));
  });

  test('Customer inequality', () {
    final customer1 = customerGenerator('id1');
    final customer2 = customerGenerator('id2');
    expect(customer1, isNot(equals(customer2)));
    expect(customer1.hashCode, isNot(equals(customer2.hashCode)));
  });
}
