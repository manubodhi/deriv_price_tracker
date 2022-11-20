import 'dart:async';

import 'package:deriv_price_tracker/data/models/active_symbols_request_model.dart';
import 'package:deriv_price_tracker/data/models/active_symbols_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/active_symbols_repository_impl.dart';

part 'available_markets_state.dart';

class AvailableMarketsCubit extends Cubit<AvailableMarketsState> {
  AvailableMarketsCubit(this._activeSymbolsRepository)
      : super(const AvailableMarketsInitial());

  final ActiveSymbolsRepositoryImpl _activeSymbolsRepository;

  Future<void> getAvailableMarkets() async {
    try {
      emit(const AvailableMarketsLoading());

      _activeSymbolsRepository
          .fetchActiveSymbols(
              activeSymbolsRequest: ActiveSymbolsRequestModel(
                  activeSymbols: "brief", productType: "basic"))
          .listen((ActiveSymbolsResponseModel event) {
        emit(AvailableMarketsLoaded(marketsList: event.activeSymbols));
      }, onError: (error) {
        emit(AvailableMarketsError(error.toString()));
      });
    } catch (e) {
      emit(AvailableMarketsError(e.toString()));
    }
  }

  Future<void> selectOneMarket(
      {required AvailableMarketsLoaded loadedState,
      required ActiveSymbols? selectedMarket}) async {
    emit(AvailableMarketsLoaded(
      marketsList: loadedState.marketsList,
      selectedMarket: selectedMarket,
    ));
  }

  Future<void> selectSymbol(
      {required AvailableMarketsLoaded loadedState,
      required ActiveSymbols? selectedSymbol}) async {
    emit(AvailableMarketsLoaded(
        marketsList: loadedState.marketsList,
        selectedMarket: loadedState.selectedMarket,
        selectedSymbol: selectedSymbol));
  }
}
