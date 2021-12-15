// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';

void main() {
  test('async value option updates state', () {
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

  test('wait for result', () async {
    final values = <AsyncValue<int>>[
      AsyncLoading(),
      AsyncLoading(),
      AsyncLoading(),
      AsyncData(4),
      AsyncLoading(),
      AsyncError('error'),
      AsyncData(5),
    ];
    final controller = StreamController<AsyncValue<int>>.broadcast();

    unawaited(
      () async {
        for (var i = 0; i < values.length; i++) {
          if (i > 0) {
            await Future<void>.delayed(Duration(milliseconds: 100));
          }
          controller.add(values[i]);
        }
      }(),
    );

    {
      final result = await controller.stream.waitForResult();
      expect(result, AsyncData(4));
    }

    {
      final result = await controller.stream.waitForResult();
      expect(result, AsyncError<int>('error'));
    }

    {
      final result = await controller.stream.waitForResult();
      expect(result, AsyncData(5));
    }
  });
}
