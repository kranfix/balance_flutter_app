import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class MockGqlClient extends Mock implements GraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

class MockMutationOptions extends Mock implements MutationOptions {}
