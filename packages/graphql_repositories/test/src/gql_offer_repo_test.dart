import 'package:graphql/client.dart';
import 'package:graphql_repositories/graphql_repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../helper/helper.dart';
import '../helper/offer_data_bank.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockMutationOptions());
  });

  test('gql offer repo is called with success', () async {
    final client = MockGqlClient();
    final OfferRepo repo = GqlOfferRepo(getClient: () => client);

    when(() => client.mutate(any())).thenAnswer(
      (_) async => QueryResult(data: offerDataResponse, source: null),
    );

    await repo.purchaseOne('id1');

    verify(() => client.mutate(captureAny())).called(1);
  });

  test('gql offer repo is called with error', () async {
    final client = MockGqlClient();
    final OfferRepo repo = GqlOfferRepo(getClient: () => client);

    when(() => client.mutate(any())).thenAnswer(
      (_) async => QueryResult(
        source: null,
        exception: OperationException(
          graphqlErrors: [
            const GraphQLError(
              message: 'Forbidden',
              locations: [
                ErrorLocation(line: 2, column: 3),
              ],
              path: <dynamic>['purchase'],
            ),
          ],
        ),
      ),
    );

    await expectLater(
      () => repo.purchaseOne('id1'),
      throwsA(isA<PurchaseOfferForbidenException>()),
    );

    verify(() => client.mutate(any())).called(1);
  });
}
