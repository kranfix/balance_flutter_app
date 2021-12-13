import 'package:flutter/material.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';
import 'package:nubank_flutter_challenge/counter/counter.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppRoot(
      child: CounterPage(),
    );
  }
}
