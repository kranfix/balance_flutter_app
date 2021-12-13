import 'package:flutter/material.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';
import 'package:nubank_flutter_challenge/customer/counter.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.providers}) : super(key: key);

  final AppProviders providers;

  @override
  Widget build(BuildContext context) {
    return AppRoot(
      providers: providers,
      child: const CustomerView(),
    );
  }
}
