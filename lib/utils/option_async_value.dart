import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:oxidized/oxidized.dart';

extension OptionAsyncValueFlattener<T> on Option<AsyncValue<T>> {
  AsyncValue<T> flat() {
    return when(
      some: (value) => value,
      none: () => const AsyncLoading(),
    );
  }
}

extension OptionAsyncValueResultWaiter<T> on Stream<Option<AsyncValue<T>>> {
  Future<AsyncValue<T>> waitForResult() {
    return map((val) => val.flat()).waitForResult();
  }
}
