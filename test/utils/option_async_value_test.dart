// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

typedef OptionAsync<T> = Option<AsyncValue<T>>;

void main() {
  test('option async value is flattened', () {
    const OptionAsync<int> option1 = None();
    expect(option1.flat(), isA<AsyncLoading>());

    const value = AsyncData(5);
    final OptionAsync<int> option2 = Some(value);
    expect(option2.flat(), equals(value));
  });

  test('wait for result', () async {
    final values = <Option<AsyncValue<int>>>[
      None(),
      Some(AsyncLoading()),
      Some(AsyncLoading()),
      Some(AsyncData(4)),
      Some(AsyncLoading()),
      Some(AsyncError('error')),
      Some(AsyncData(5)),
    ];
    final controller = StreamController<Option<AsyncValue<int>>>.broadcast();

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
