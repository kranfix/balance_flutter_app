// ignore_for_file: prefer_const_constructors

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test('async value helpers tell if is loading or if has result', () {
    expect(AsyncLoading<int>().isLoading, true);
    expect(AsyncLoading<int>().hasResult, false);

    expect(AsyncData<int>(1).isLoading, false);
    expect(AsyncData<int>(1).hasResult, true);

    expect(AsyncError<int>('message').isLoading, false);
    expect(AsyncError<int>('message').hasResult, true);
  });
}
