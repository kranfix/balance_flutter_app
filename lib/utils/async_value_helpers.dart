import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueHelpers<T> on AsyncValue<T> {
  bool get isLoading => this is AsyncLoading;
  bool get hasResult => this is! AsyncLoading;
}
