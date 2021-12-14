import 'package:domain/domain.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:riverbloc/riverbloc.dart';

export 'customer/customer_bloc.dart';

/// Provider for the [CustomerRepo].
final customerRepoPod = Provider<CustomerRepo>(
  (_) => throw UnimplementedProviderError('customerRepoPod'),
  name: 'customerRepoPod',
);

/// Provider for [Customer] state.
final customerPod = BlocProvider<CustomerBloc, CustomerState>((ref) {
  return CustomerBloc(
    getCustomerRepo: () => ref.read(customerRepoPod),
    getOfferRepo: () => ref.read(offerRepoPod),
  );
});
