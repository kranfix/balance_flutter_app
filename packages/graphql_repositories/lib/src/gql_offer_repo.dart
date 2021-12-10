import 'package:domain/domain.dart';
import 'package:graphql/client.dart';

const _purchaseOffer = r'''
mutation purchaseOffer($offerId: ID!) {
  purchase(offerId: $offerId) {
    success
    errorMessage
  }
}
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
  Future<void> purchaseOne(String offerId) async {
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
  }
}
