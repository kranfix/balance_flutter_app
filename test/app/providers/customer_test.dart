import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_flutter_challenge/app/providers/providers.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:test/test.dart';

class CustomerMockRepo extends Mock implements CustomerRepo {}

class OfferMockRepo extends Mock implements OfferRepo {}

const customer1b300 = Customer(
  id: '1',
  name: 'Fulano',
  balance: 300,
  offers: [],
);

const customer1b200 = Customer(
  id: '1',
  name: 'Fulano',
  balance: 200,
  offers: [],
);

void main() {
  test('Reading unoverriden customerRepoPod throws an Exception', () {
    final container = ProviderContainer();
    expect(
      () => container.read(customerRepoPod),
      throwsA(isA<ProviderException>()),
    );

    container.dispose();
  });

  test('customer initiliazation with and without force', () async {
    final customerRepo = CustomerMockRepo();
    final offerRepo = OfferMockRepo();

    final container = ProviderContainer(
      overrides: [
        customerRepoPod.overrideWithValue(customerRepo),
        offerRepoPod.overrideWithValue(offerRepo),
      ],
    );

    when(customerRepo.fetchMe).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return customer1b300;
    });

    final customerBloc = container.read(customerPod.bloc);

    expect(customerBloc.state, isA<None>());

    verifyNever(customerRepo.fetchMe);

    customerBloc.add(const Initialized());

    await Future(() {});
    verify(customerRepo.fetchMe).called(1);

    expect(customerBloc.state.unwrap(), isA<AsyncLoading>());

    final _state = await customerBloc.stream.first;
    expect(_state.unwrap(), isA<AsyncData>());
    expect(customerBloc.state.unwrap(), isA<AsyncData>());
    expect(
      customerBloc.state.unwrap().asData!.value.balance,
      equals(300),
    );

    verifyNever(customerRepo.fetchMe);
    customerBloc.add(const Initialized());
    await Future(() {});
    verifyNever(customerRepo.fetchMe);

    when(customerRepo.fetchMe).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return customer1b200;
    });

    verifyNever(customerRepo.fetchMe);
    customerBloc.add(const Initialized(force: true));
    await Future(() {});
    verify(customerRepo.fetchMe).called(1);

    final __state = await customerBloc.stream.first;
    expect(__state.unwrap(), isA<AsyncData>());
    expect(customerBloc.state.unwrap(), isA<AsyncData>());
    expect(
      customerBloc.state.unwrap().asData!.value.balance,
      equals(200),
    );

    container.dispose();
  });

  test('customer initiliazation throws an exception', () async {
    final customerRepo = CustomerMockRepo();
    final offerRepo = OfferMockRepo();

    final container = ProviderContainer(
      overrides: [
        customerRepoPod.overrideWithValue(customerRepo),
        offerRepoPod.overrideWithValue(offerRepo),
      ],
    );

    when(customerRepo.fetchMe).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      throw const UnauthorizedException();
    });

    final customerBloc = container.read(customerPod.bloc);

    expect(customerBloc.state, isA<None>());

    verifyNever(customerRepo.fetchMe);

    customerBloc.add(const Initialized());

    await Future(() {});
    verify(customerRepo.fetchMe).called(1);

    expect(customerBloc.state.unwrap(), isA<AsyncLoading>());

    final _state = await customerBloc.stream.first;
    expect(_state.unwrap(), isA<AsyncError>());

    container.dispose();
  });

  test('Customer purchase an offer and updates the customer', () async {
    final customerRepo = CustomerMockRepo();
    final offerRepo = OfferMockRepo();

    final container = ProviderContainer(
      overrides: [
        customerRepoPod.overrideWithValue(customerRepo),
        offerRepoPod.overrideWithValue(offerRepo),
      ],
    );

    when(customerRepo.fetchMe).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return customer1b300;
    });

    final customerBloc = container.read(customerPod.bloc)
      ..add(const Initialized());
    await Future(() {});

    await customerBloc.stream.first;
    expect(
      customerBloc.state.unwrap().asData!.value.balance,
      equals(300),
    );

    when(() => offerRepo.purchaseOne('id1')).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return customer1b200;
    });

    customerBloc.add(const OfferPurchased('id1'));
    await customerBloc.stream.first;
    expect(customerBloc.state.unwrap(), isA<AsyncLoading>());

    await customerBloc.stream.first;
    expect(
      customerBloc.state.unwrap().asData!.value.balance,
      equals(200),
    );
  });

  test('purchasing an offer throws an exception', () async {
    final customerRepo = CustomerMockRepo();
    final offerRepo = OfferMockRepo();

    final container = ProviderContainer(
      overrides: [
        customerRepoPod.overrideWithValue(customerRepo),
        offerRepoPod.overrideWithValue(offerRepo),
      ],
    );

    final customerBloc = container.read(customerPod.bloc);

    expect(customerBloc.state, isA<None>());

    customerBloc.add(const OfferPurchased('id1'));
    await customerBloc.stream.first;
    expect(customerBloc.state.unwrap(), isA<AsyncError>());

    container.dispose();
  });
}
