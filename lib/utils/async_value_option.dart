import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';

extension AsyncValueOptionStateUpdater<T> on AsyncValue<T> {
  AsyncValue<T> updateWith(Option<AsyncValue<T>> curr) {
    return curr.match(
      (val) => val.when(
        data: (_) => val,
        loading: () => this,
        error: (e, s) => maybeWhen(
          data: (_) => this,
          orElse: () => val,
        ),
      ),
      () => this,
    );
  }
}
