export 'option_async_value.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';

extension OptionAsyncValueFlattener<T> on Option<AsyncValue<T>> {
  AsyncValue<T> flat() {
    return when(
      some: (value) => value,
      none: () => const AsyncLoading(),
    );
  }
}
