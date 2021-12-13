// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:nubank_flutter_challenge/l10n/l10n.dart';

class CustomerView extends ConsumerWidget {
  const CustomerView({Key? key}) : super(key: key);

  static late final pod = Provider<AsyncValue<Customer>>((ref) {
    final customerBloc = ref.read(customerPod.bloc)..add(const Initialized());
    var lastVal = customerBloc.state.match(
      (val) => val,
      () => const AsyncLoading<Customer>(),
    );
    ref.listen<CustomerState>(
      customerPod,
      (prev, curr) => ref.state = curr.match(
        (val) => val.when(
          data: (_) => lastVal = val,
          loading: () => lastVal,
          error: (e, s) => lastVal.maybeWhen(
            error: (e, s) => lastVal = val,
            orElse: () => lastVal,
          ),
        ),
        () => lastVal,
      ),
    );
    return lastVal;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(pod);
            return state.when(
              data: (customer) => CustomerBody(customer: customer),
              error: (e, _) => const Loader(),
              loading: () => const Loader(),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
                ref.read(customerPod.bloc).add(const Initialized()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () =>
                ref.read(customerPod.bloc).add(const Initialized()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CustomerBody extends ConsumerWidget {
  const CustomerBody({
    Key? key,
    required this.customer,
  }) : super(key: key);

  final Customer customer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 9 / 12,
      ),
      padding: const EdgeInsets.all(20),
      itemCount: customer.offers.length,
      itemBuilder: (context, index) => OfferCard(
        offer: customer.offers[index],
      ),
    );
  }
}

class OfferCard extends ConsumerWidget {
  const OfferCard({Key? key, required this.offer}) : super(key: key);

  final Offer offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(offer.product.image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 4),
              Text(
                '${offer.price} USD',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(offer.product.name),
            ],
          ),
        ),
      ),
    );
  }
}

class Loader extends ConsumerWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CircularProgressIndicator();
  }
}
