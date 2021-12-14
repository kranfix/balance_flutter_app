// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {AppProviders? providers}) {
    return pumpWidget(
      AppRoot(
        providers: providers ?? mockedAppProviders,
        child: widget,
      ),
    );
  }
}
