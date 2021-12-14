// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';

void main() {
  testWidgets('async value option updates state', (tester) async {
    {
      const AsyncValue<int> state = AsyncLoading();
      expect(state.updateWith(None()), isA<AsyncLoading>());
      expect(state.updateWith(Some(AsyncLoading())), isA<AsyncLoading>());
      expect(state.updateWith(Some(AsyncData(4))), equals(AsyncData(4)));
      expect(
        state.updateWith(Some(AsyncError('error'))),
        equals(AsyncError<int>('error')),
      );
    }

    {
      const AsyncValue<int> state = AsyncData(0);
      expect(state.updateWith(None()), isA<AsyncData>());
      expect(state.updateWith(Some(AsyncLoading())), equals(AsyncData(0)));
      expect(state.updateWith(Some(AsyncData(4))), equals(AsyncData(4)));
      expect(
        state.updateWith(Some(AsyncError('error'))),
        equals(AsyncData(0)),
      );
    }

    {
      const AsyncValue<int> state = AsyncError('error');
      expect(state.updateWith(None()), isA<AsyncError>());
      expect(state.updateWith(Some(AsyncLoading())), isA<AsyncError>());
      expect(state.updateWith(Some(AsyncData(4))), equals(AsyncData(4)));
      expect(
        state.updateWith(Some(AsyncError('error1'))),
        equals(AsyncError<int>('error1')),
      );
    }
  });
}
