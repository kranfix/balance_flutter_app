import 'package:domain/domain.dart';
import 'package:graphql/client.dart';
import 'package:graphql_repositories/utils/utils.dart';

const _fetchMeQuery = '''
query fetchMe {
  viewer {...customerData}
}

$customerDataFragment
''';

/// Fragment for the customer data
const customerDataFragment = '''
fragment customerData on Customer {
  id
  name
  balance
  offers {
    id
    price
    product {
      id
      name
      description
      image
    }
  }
}''';

/// {@template graphql_repositories.GqlCustomerRepo}
/// A repository that uses GraphQL for handling customers.
/// {@endtemplate}
class GqlCustomerRepo implements CustomerRepo {
  /// {@macro graphql_repositories.GqlCustomerRepo}
  GqlCustomerRepo({required this.getClient});

  /// Allows the repository to know how to read the injected graphql client.
  final GraphQLClient Function() getClient;

  @override
  Future<Customer> fetchMe() async {
    final client = getClient();

    final options = QueryOptions(
      document: gql(_fetchMeQuery),
    );

    final result = await client.query(options);

    if (result.hasException) {
      //result.exception!.graphqlErrors.first.message;
      throw const UnauthorizedException();
    }

    final viewer = result.data!['viewer'] as JMap;
    return Customer(
      id: viewer['id'] as String,
      name: viewer['name'] as String,
      balance: viewer['balance'] as int,
      offers: (viewer['offers'] as List<dynamic>).toOfferList(),
    );
  }
}

// ignore: public_member_api_docs
extension ProductFromJson on JMap {
  /// Converts a [JMap] to a [Product].
  Product toProduct() => Product(
        id: this['id'] as String,
        name: this['name'] as String,
        description: this['description'] as String,
        image: this['image'] as String,
      );
}

// ignore: public_member_api_docs
extension OfferFromJson on JMap {
  /// Converts a [JMap] to a [Offer].
  Offer toOffer() => Offer(
        id: this['id'] as String,
        price: this['price'] as int,
        product: (this['product'] as JMap).toProduct(),
      );
}

// ignore: public_member_api_docs
extension ListOfferFromJson on List<dynamic> {
  /// Converts a [List] of [dynamic] to a [List] of [Offer].
  List<Offer> toOfferList() {
    return [
      for (final dynamic _offer in this) (_offer as JMap).toOffer(),
    ];
  }
}

// ignore: public_member_api_docs
extension CustomerFromJson on JMap {
  /// Converts a [JMap] to a [Customer].
  Customer toCustomer() => Customer(
        id: this['id'] as String,
        name: this['name'] as String,
        balance: this['balance'] as int,
        offers: (this['offers'] as List<dynamic>).toOfferList(),
      );
}
