import 'package:balance_app_base/src/balance_app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final valueProvider = Provider((ref) => 5);

void main() {
  testWidgets('balance app root ...', (tester) async {
    ThemeData? theme;
    late int value;

    await tester.pumpWidget(
      BalanceAppRoot(
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
