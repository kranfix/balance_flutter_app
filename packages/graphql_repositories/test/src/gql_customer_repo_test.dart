import 'package:graphql/client.dart';
import 'package:graphql_repositories/graphql_repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../helper/customer_data_bank.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockQueryOptions());
  });

  test('gql customer repo is called with success', () async {
    final client = MockGqlClient();
    final CustomerRepo repo = GqlCustomerRepo(getClient: () => client);

    when(() => client.query(any())).thenAnswer(
      (_) async => QueryResult(data: viewerDataResponse, source: null),
    );

    final customer = await repo.fetchMe();

    verify(() => client.query(captureAny())).called(1);
    expect(customer, isA<Customer>());
  });

  test('gql customer repo is called with error', () async {
    final client = MockGqlClient();
    final CustomerRepo repo = GqlCustomerRepo(getClient: () => client);

    when(() => client.query(any())).thenAnswer(
      (_) async => QueryResult(
        source: null,
        exception: OperationException(
          graphqlErrors: [
            const GraphQLError(
              message: 'Unauthorized',
              locations: [
                ErrorLocation(line: 2, column: 3),
              ],
              path: <dynamic>['viewer'],
            ),
          ],
        ),
      ),
    );

    try {
      await repo.fetchMe();
      fail('CustomerRepo.fetchMe should throw UnauthorizedException');
    } catch (e) {
      expect(e, isA<UnauthorizedException>());
    }

    verify(() => client.query(captureAny())).called(1);
  });
}
