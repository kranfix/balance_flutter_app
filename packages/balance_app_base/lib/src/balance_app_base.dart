import 'package:balance_app_base/src/balance_app_root.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// {@template balance_app}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class BalanceApp extends ConsumerWidget {
  /// {@macro balance_app}
  const BalanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BalanceAppRoot(
      child: Offstage(),
    );
  }
}
