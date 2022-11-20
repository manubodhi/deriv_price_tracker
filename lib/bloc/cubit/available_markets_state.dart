part of 'available_markets_cubit.dart';

abstract class AvailableMarketsState extends Equatable {
  const AvailableMarketsState();
}

class AvailableMarketsInitial extends AvailableMarketsState {
  const AvailableMarketsInitial();

  @override
  List<Object> get props => [];
}

class AvailableMarketsLoading extends AvailableMarketsState {
  const AvailableMarketsLoading();

  @override
  List<Object> get props => [];
}

class AvailableMarketsLoaded extends AvailableMarketsState {
  AvailableMarketsLoaded({
    required List<ActiveSymbols> marketsList,
    ActiveSymbols? selectedMarket,
    ActiveSymbols? selectedSymbol,
  })  : _marketsList = marketsList,
        _selectedMarket = selectedMarket ??
            (marketsList.isNotEmpty ? marketsList.first : null),
        _selectedSymbol = selectedSymbol;

  final List<ActiveSymbols> _marketsList;

  final ActiveSymbols? _selectedMarket;

  final ActiveSymbols? _selectedSymbol;

  List<ActiveSymbols> get marketsList => _marketsList;

  List<ActiveSymbols> get symbolsList => _marketsList
      .where((element) => element.market == selectedMarket?.market)
      .toList();

  ActiveSymbols? get selectedMarket => _selectedMarket;

  ActiveSymbols? get selectedSymbol => _selectedSymbol;

  @override
  List<Object?> get props => [marketsList, _selectedMarket, selectedSymbol];
}

class AvailableMarketsError extends AvailableMarketsState {
  const AvailableMarketsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
