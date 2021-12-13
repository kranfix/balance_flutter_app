import 'dart:async';

import 'package:domain/domain.dart';
import 'package:meta/meta.dart';
import 'package:oxidized/oxidized.dart';
import 'package:riverbloc/riverbloc.dart';

part 'customer_event.dart';

typedef CustomerState = Option<AsyncValue<Customer>>;

typedef Getter<T> = T Function();
typedef AsyncGetter<T> = Future<T> Function();

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc({
    required this.getCustomerRepo,
    required this.getOfferRepo,
  }) : super(const None()) {
    on<Initialized>(initialize);
    on<OfferPurchased>(purchaseOffer);
  }

  final Getter<CustomerRepo> getCustomerRepo;
  final Getter<OfferRepo> getOfferRepo;

  @protected
  FutureOr<void> initialize(
    Initialized event,
    Emitter<CustomerState> emit,
  ) {
    if (state.isSome() && !event.force) {
      return null;
    }
    return restart(emit);
  }

  @protected
  Future<void> restart(Emitter<CustomerState> emit) async {
    emit(Some(const AsyncLoading()));
    try {
      final customer = await getCustomerRepo().fetchMe();
      emit(Some(AsyncData(customer)));
    } catch (e, s) {
      emit(Some(AsyncError(e, stackTrace: s)));
    }
  }

  @protected
  Future<void> purchaseOffer(
    OfferPurchased event,
    Emitter<CustomerState> emit,
  ) async {
    emit(Some(const AsyncLoading()));
    try {
      final customer = await getOfferRepo().purchaseOne(event.offerId);
      emit(Some(AsyncData(customer)));
    } catch (e, s) {
      emit(Some(AsyncError(e, stackTrace: s)));
    }
  }
}
