import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/app/providers/customer.dart';
import 'package:nubank_flutter_challenge/l10n/l10n.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';
import 'package:nubank_flutter_challenge/widgets/widgets.dart';

class OfferView extends ConsumerWidget {
  const OfferView({Key? key, required this.offer}) : super(key: key);

  final Offer offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(offer.product.name),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              offer.product.image,
              width: double.infinity,
              height: mq.size.height / 3,
              fit: BoxFit.fitWidth,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    offer.product.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Price: ${offer.price} USD',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    offer.product.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          LoadingDialog.show<void>(
            context,
            futureBuilder: () async {
              final customerBloc = ref.read(customerPod.bloc)
                ..add(OfferPurchased(offer.id));
              final result = await customerBloc.stream.waitForResult();

              final completer = Completer<void>();
              result.whenOrNull(
                data: completer.complete,
                error: completer.completeError,
              );
              return completer.future;
            },
            onSuccess: (_) => Navigator.of(context).pop(),
          );
        },
        label: Text(l10n.purchase),
      ),
    );
  }

  static Future<void> navigate(BuildContext context, Offer offer) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: '/offer/${offer.id}'),
        builder: (context) => OfferView(offer: offer),
      ),
    );
  }
}
