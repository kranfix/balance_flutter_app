#!/bin/bash
# Run depending of the enviroment:
#
# bash config_generator.sh > config_development.dart
# bash config_generator.sh > config_staging.dart
# bash config_generator.sh > config_production.dart

echo "
// ignore_for_file: lines_longer_than_80_chars
import 'package:nubank_flutter_challenge/config/config.dart';

const config = AppConfig(
  serverUrl: '$SERVE_URL',
  token: '$TOKEN',
);
" > lib/config/config.dart