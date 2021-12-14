import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_flutter_challenge/l10n/l10n.dart';
import '../helpers/helpers.dart';

void main() {
  testWidgets('l10n ...', (tester) async {
    AppLocalizations? l10n;
    await tester.pumpApp(
      Builder(
        builder: (context) {
          l10n = context.l10n;
          return const Offstage();
        },
      ),
    );
    expect(l10n, isNotNull);
  });
}
