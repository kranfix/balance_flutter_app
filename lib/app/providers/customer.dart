import 'package:domain/domain.dart';
import 'package:riverbloc/riverbloc.dart';

/// Provider for the [CustomerRepo].
final customerRepoPod = Provider<CustomerRepo>(
  (_) => throw UnimplementedProviderError('customerRepoPod'),
  name: 'customerRepoPod',
);

/// Provider for [Customer] state.
final customerPod = FutureProvider<Customer>((ref) async {
  final customerRepo = ref.watch(customerRepoPod);
  return customerRepo.fetchMe();
});
