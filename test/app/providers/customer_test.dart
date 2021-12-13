import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';

class CustomerMockRepo extends Mock implements CustomerRepo {}

void main() {
  test('customer ...', () async {
    final customerRepo = CustomerMockRepo();
    final container = ProviderContainer(
      overrides: [
        customerRepoPod.overrideWithValue(customerRepo),
      ],
    );

    when(customerRepo.fetchMe).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return const Customer(
        id: '1',
        name: 'Fulano',
        balance: 300,
        offers: [],
      );
    });

    final future = container.read(customerPod.future);

    verify(customerRepo.fetchMe).called(1);

    final loading = container.read(customerPod);
    expect(loading, isA<AsyncLoading>());

    await future;

    final data = container.read(customerPod);
    expect(data, isA<AsyncData>());

    container.dispose();
  });
}
