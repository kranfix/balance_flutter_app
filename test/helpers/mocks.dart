import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';
import 'package:riverbloc/riverbloc.dart';

class CustomerMockRepo extends Mock implements CustomerRepo {}

class OfferMockRepo extends Mock implements OfferRepo {}

final mockedAppProviders = AppProviders(
  customerRepoPod: Provider((ref) => CustomerMockRepo()),
  offerRepoPod: Provider((ref) => OfferMockRepo()),
);
