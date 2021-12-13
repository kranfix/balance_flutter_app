import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';

final valueProvider = Provider((ref) => 5);

void main() {
  testWidgets('app root injects by context and by ref', (tester) async {
    ThemeData? theme;
    late int value;
    await tester.pumpWidget(
      AppRoot(
        child: Consumer(
          builder: (context, ref, child) {
            theme = Theme.of(context);
            value = ref.watch(valueProvider);
            return const Offstage();
          },
        ),
      ),
    );

    expect(theme, isNotNull);
    expect(value, 5);
  });
}
