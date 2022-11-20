part of 'ticking_price_cubit.dart';

abstract class TickingPriceState extends Equatable {
  const TickingPriceState();
}

class TickingPriceInitial extends TickingPriceState {
  const TickingPriceInitial();

  @override
  List<Object> get props => [];
}

class TickingPriceLoading extends TickingPriceState {
  const TickingPriceLoading();

  @override
  List<Object> get props => [];
}

class TickingPriceLoaded extends TickingPriceState {
  final Tick? _tick;
  final Tick? _previousTick;

  const TickingPriceLoaded({
    required Tick? tick,
    Tick? previousTick,
  })  : _tick = tick,
        _previousTick = previousTick;

  Tick? get tick => _tick;

  Tick? get previousTick => _previousTick;

  @override
  List<Object?> get props => [_tick, _previousTick];
}

class TickingPriceError extends TickingPriceState {
  const TickingPriceError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
