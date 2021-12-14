import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:nubank_flutter_challenge/customer/view/offer_view.dart';
import 'package:nubank_flutter_challenge/l10n/l10n.dart';
import 'package:nubank_flutter_challenge/utils/utils.dart';

class CustomerView extends ConsumerWidget {
  const CustomerView({Key? key}) : super(key: key);

  static late final pod = Provider<AsyncValue<Customer>>((ref) {
    final customerBloc = ref.read(customerPod.bloc)..add(const Initialized());
    ref.listen<CustomerState>(
      customerPod,
      (prev, curr) => ref.state = ref.state.updateWith(curr),
    );
    return customerBloc.state.flat();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.balanceAppTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Consumer(
              key: const Key('balance'),
              builder: (context, ref, _) {
                final state = ref.watch(pod);
                return state.maybeWhen(
                  data: (customer) => Text(
                    '${customer.balance} USD',
                    style: const TextStyle(fontSize: 24),
                  ),
                  orElse: () => const Offstage(),
                );
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: Consumer(
          key: const Key('offers'),
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
        childAspectRatio: 3 / 4,
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
    return GestureDetector(
      onTap: () => OfferView.navigate(context, offer),
      child: ClipRRect(
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
