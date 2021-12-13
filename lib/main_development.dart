import 'package:graphql/client.dart';
import 'package:graphql_repositories/graphql_repositories.dart';
import 'package:nubank_flutter_challenge/app/app.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';
import 'package:nubank_flutter_challenge/bootstrap.dart';
import 'package:nubank_flutter_challenge/config/config_development.dart';
import 'package:riverbloc/riverbloc.dart';

void main() {
  final _httpLink = HttpLink(
    config.serverUrl,
  );

  final _authLink = AuthLink(
    getToken: () async => 'Bearer ${config.token}',
  );

  final _link = _authLink.concat(_httpLink);

  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );

  bootstrap(
    () => App(
      providers: AppProviders(
        customerRepoPod: Provider(
          (ref) => GqlCustomerRepo(getClient: () => client),
        ),
        offerRepoPod: Provider(
          (ref) => GqlOfferRepo(getClient: () => client),
        ),
      ),
    ),
  );
}
