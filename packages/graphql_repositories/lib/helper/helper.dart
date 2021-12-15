// ignore_for_file: public_member_api_docs

import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

export 'customer_data_bank.dart';
export 'offer_data_bank.dart';

class MockGqlClient extends Mock implements GraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

class MockMutationOptions extends Mock implements MutationOptions {}
