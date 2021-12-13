import 'package:domain/domain.dart';
import 'package:graphql/client.dart';
import 'package:graphql_repositories/src/gql_customer_repo.dart';
import 'package:graphql_repositories/utils/utils.dart';

const _purchaseOffer = '''
mutation purchaseOffer(\$offerId: ID!) {
  purchase(offerId: \$offerId) {
    success
    errorMessage
    customer {...customerData}
  }
}

$customerDataFragment
''';

/// {@template graphql_repositories.GqlOfferRepo}
/// Implementatioin of [OfferRepo] based on ferry graphql client.
/// {@endtemplate}
class GqlOfferRepo implements OfferRepo {
  /// {@macro graphql_repositories.GqlOfferRepo}
  GqlOfferRepo({required this.getClient});

  /// Getter for the graphql client.
  final GraphQLClient Function() getClient;

  @override
  Future<Customer> purchaseOne(String offerId) async {
    final client = getClient();

    final options = MutationOptions(
      document: gql(_purchaseOffer),
      variables: <String, dynamic>{
        'offerId': offerId,
      },
    );

    final result = await client.mutate(options);

    if (result.hasException) {
      throw PurchaseOfferForbidenException(offerId);
    }

    final purchase = result.data!['purchase'] as JMap;
    final customer = purchase['customer'] as JMap;
    return customer.toCustomer();
  }
}
