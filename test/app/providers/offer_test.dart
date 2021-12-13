import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';

void main() {
  test('Reading unoverriden offerRepoPod throws an Exception', () {
    final container = ProviderContainer();
    expect(
      () => container.read(offerRepoPod),
      throwsA(isA<ProviderException>()),
    );

    container.dispose();
  });
}
