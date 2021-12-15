import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:nubank_flutter_challenge/widgets/commons/commons.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Container(
        color: theme.scaffoldBackgroundColor,
        height: 250,
        width: 250,
        alignment: Alignment.center,
        child: const SizedBox(
          width: 60,
          height: 60,
          child: Loader(),
        ),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required AsyncValueGetter<T> futureBuilder,
    ValueSetter<T>? onSuccess,
    AsyncValueConverter<dynamic, T>? onError,
  }) {
    futureBuilder().then(
      (value) {
        Navigator.pop(context);
        onSuccess?.call(value);
      },
      onError: (dynamic err) async {
        Navigator.pop(context);
        await onError?.call(err);
      },
    );
    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (context) => const LoadingDialog(),
    );
  }
}
