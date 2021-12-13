import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:nubank_flutter_challenge/l10n/l10n.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({
    Key? key,
    required this.providers,
    required this.child,
  }) : super(key: key);

  final AppProviders providers;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        customerRepoPod.overrideWithProvider(providers.customerRepoPod),
        offerRepoPod.overrideWithProvider(providers.offerRepoPod),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }
}

class AppProviders {
  const AppProviders({
    required this.customerRepoPod,
    required this.offerRepoPod,
  });

  final Provider<CustomerRepo> customerRepoPod;
  final Provider<OfferRepo> offerRepoPod;
}
