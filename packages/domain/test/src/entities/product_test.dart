import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  test('product equality', () {
    Product productGenerator(String id) => Product(
          id: id,
          name: 'Red Shirt',
          description: 'A red shirt - it is pretty red!',
          image: 'https://example.com/image.png',
        );
    final product1 = productGenerator('p1');
    final product2 = productGenerator('p1');
    expect(product1, product2);
    expect(product1, isNot(same(product2)));
    expect(product1.hashCode, product2.hashCode);
  });

  test('product inequality', () {
    const product1 = Product(
      id: 'p1',
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      image: 'https://example.com/image1.png',
    );
    const product2 = Product(
      id: 'p2',
      name: 'Blue Shirt',
      description: 'A blue shirt - it is pretty blue!',
      image: 'https://example.com/image2.png',
    );
    expect(product1, isNot(equals(product2)));
    expect(product1.hashCode, isNot(equals(product2.hashCode)));
  });

  test('product to string', () {
    const product = Product(
      id: 'p1',
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      image: 'https://example.com/image.png',
    );

    expect(
      product.toString(),
      '''
Product(id: p1, name: Red Shirt, description: A red shirt - it is pretty red!, image: https://example.com/image.png)''',
    );
  });
}
