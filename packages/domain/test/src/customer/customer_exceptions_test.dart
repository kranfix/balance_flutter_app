import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  test('CustomerException to string', () {
    const exception = UnauthorizedException();
    expect(exception.toString(), 'UnauthorizedException()');
  });
}
