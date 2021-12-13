import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// {@template balance_app_base.BalanceAppRoot}
/// {@endtemplate}
class BalanceAppRoot extends StatelessWidget {
  /// {@macro balance_app_base.BalanceAppRoot}
  const BalanceAppRoot({Key? key, required this.child}) : super(key: key);

  ///
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Balance',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: child,
      ),
    );
  }
}