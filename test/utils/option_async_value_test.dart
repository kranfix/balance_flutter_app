import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';

typedef OptionAsync<T> = Option<AsyncValue<T>>;

void main() {
  test('option async value is flattened', () {
    const OptionAsync<int> option1 = None();
    expect(option1.flat(), isA<AsyncLoading>());

    const value = AsyncData(5);
    final OptionAsync<int> option2 = Some(value);
    expect(option2.flat(), equals(value));
  });
}
