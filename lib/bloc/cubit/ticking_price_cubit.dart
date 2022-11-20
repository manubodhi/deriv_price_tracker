import 'package:deriv_price_tracker/data/models/active_symbols_response_model.dart';
import 'package:deriv_price_tracker/data/models/forget_request_model.dart';
import 'package:deriv_price_tracker/data/models/ticks_stream_request_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/ticks_stream_response_model.dart';
import '../../data/repos/ticking_price_repository.dart';
import 'available_markets_cubit.dart';

part 'ticking_price_state.dart';

class TickingPriceCubit extends Cubit<TickingPriceState> {
  final TickingPriceRepository _ticksRepository;

  String? _ticksSubscriptionId;

  Tick? _lastTick;

  TickingPriceCubit(this._ticksRepository, AvailableMarketsCubit marketsCubit)
      : super(const TickingPriceInitial()) {
    marketsCubit.stream.listen((AvailableMarketsState marketsState) async {
      if (marketsState is AvailableMarketsLoaded) {
        if (marketsState.selectedSymbol != null) {
          subscribeTicks(selectedSymbol: marketsState.selectedSymbol);
        }
      }
    });
  }

  Future<void> subscribeTicks({required ActiveSymbols? selectedSymbol}) async {
    try {
      emit(const TickingPriceLoading());
      _ticksRepository
          .subscribeTicks(
              ticksRequest: TicksStreamRequestModel(
                  ticks: selectedSymbol!.symbol, subscribe: 1))
          .listen((TicksStreamResponseModel event) {
        _ticksSubscriptionId = event.subscription?.id;
        emit(TickingPriceLoaded(tick: event.tick, previousTick: _lastTick));
        _lastTick = event.tick;
      }, onError: (error) {
        emit(TickingPriceError(error.toString()));
      });
    } catch (e) {
      emit(TickingPriceError(e.toString()));
    }
  }

  Future<void> unSubscribeTicks({required String subscriptionId}) async {
    _ticksRepository.unSubscribeTicks(
        forgetRequest: ForgetRequestModel(forget: subscriptionId));
  }

  @override
  Future<void> close() async {
    if (_ticksSubscriptionId != null) {
      await unSubscribeTicks(subscriptionId: _ticksSubscriptionId!);
    }
    super.close();
  }
}
