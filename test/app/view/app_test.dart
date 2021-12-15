import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:graphql_repositories/graphql_repositories.dart';
import 'package:graphql_repositories/helper/helper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nubank_flutter_challenge/app/view/app.dart';
import 'package:nubank_flutter_challenge/app/view/app_root.dart';
import 'package:nubank_flutter_challenge/customer/customer.dart';
import 'package:nubank_flutter_challenge/customer/view/offer_view.dart';
import 'package:nubank_flutter_challenge/widgets/widgets.dart';
import 'package:riverbloc/riverbloc.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockQueryOptions());
    registerFallbackValue(MockMutationOptions());
  });

  testWidgets('app with happy path', (tester) async {
    await mockNetworkImages(() async {
      final client = MockGqlClient();
      final customerRepo = GqlCustomerRepo(getClient: () => client);
      final offerRepo = GqlOfferRepo(getClient: () => client);
      final providers = AppProviders(
        customerRepoPod: Provider((ref) => customerRepo),
        offerRepoPod: Provider((ref) => offerRepo),
      );

      when(() => client.query(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        return QueryResult(data: viewerDataResponse, source: null);
      });

      await tester.pumpWidget(
        App(providers: providers),
      );

      final customerViewFinder = find.byType(CustomerView);
      expect(customerViewFinder, findsOneWidget);

      final customerBalanceFinder = find.descendant(
        of: customerViewFinder,
        matching: find.byKey(const Key('balance')),
      );
      final offersFinder = find.descendant(
        of: customerViewFinder,
        matching: find.byKey(const Key('offers')),
      );

      expect(customerBalanceFinder, findsOneWidget);
      final balanceTextFinder = find.descendant(
        of: customerBalanceFinder,
        matching: find.byType(Text),
      );
      expect(balanceTextFinder, findsNothing);

      final offersLoadingFinder = find.descendant(
        of: offersFinder,
        matching: find.byType(Loader),
      );
      final offersGridViewFinder = find.descendant(
        of: offersFinder,
        matching: find.byType(GridView),
      );
      expect(offersLoadingFinder, findsOneWidget);
      expect(offersGridViewFinder, findsNothing);

      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(balanceTextFinder, findsOneWidget);
      {
        final balanceText = tester.widget<Text>(balanceTextFinder);
        expect(balanceText.data, '1000000 USD');
      }
      expect(offersLoadingFinder, findsNothing);
      expect(offersGridViewFinder, findsOneWidget);

      final offerCardFinder = find.descendant(
        of: offersGridViewFinder,
        matching: find.byType(OfferCard),
      );

      await tester.tap(offerCardFinder.first);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(customerViewFinder, findsNothing);

      final offerViewFinder = find.byType(OfferView);
      expect(offerViewFinder, findsOneWidget);

      final offerViewBackButtonFinder = find.descendant(
        of: offerViewFinder,
        matching: find.byType(BackButton),
      );
      expect(offerViewBackButtonFinder, findsOneWidget);
      await tester.tap(offerViewBackButtonFinder);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));
      expect(customerViewFinder, findsOneWidget);
      expect(offerViewFinder, findsNothing);

      await tester.tap(offerCardFinder.first);
      await tester.pumpAndSettle(const Duration(milliseconds: 400));

      when(() => client.mutate(any())).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 600));
        return QueryResult(data: offerDataResponse, source: null);
      });

      final offerViewPurchaseButtonFinder = find.descendant(
        of: offerViewFinder,
        matching: find.byType(FloatingActionButton),
      );
      expect(offerViewPurchaseButtonFinder, findsOneWidget);

      await tester.tap(offerViewPurchaseButtonFinder);

      await tester.pumpAndSettle(const Duration(milliseconds: 350));

      expect(offerViewFinder, findsNothing);
      expect(customerViewFinder, findsOneWidget);

      {
        final balanceText = tester.widget<Text>(balanceTextFinder);
        expect(balanceText.data, '995000 USD');
      }
    });
  });
}
