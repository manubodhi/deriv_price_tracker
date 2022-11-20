import 'package:deriv_price_tracker/constants/app_text_styles.dart';
import 'package:deriv_price_tracker/constants/images.dart';
import 'package:deriv_price_tracker/constants/strings.dart';
import 'package:deriv_price_tracker/data/models/active_symbols_response_model.dart';
import 'package:deriv_price_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/available_markets_cubit.dart';
import '../bloc/cubit/ticking_price_cubit.dart';
import '../data/repos/ticking_price_repository_impl.dart';
import 'common_widgets/list_dropdown.dart';
import 'common_widgets/dynamic_price_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AvailableMarketsCubit? _availableMarketsCubit;
  TickingPriceCubit? _ticksCubit;

  @override
  void dispose() {
    super.dispose();
    _availableMarketsCubit!.close();
    _ticksCubit!.close();
  }

  @override
  void initState() {
    super.initState();
    _availableMarketsCubit = BlocProvider.of<AvailableMarketsCubit>(context);
    _ticksCubit = TickingPriceCubit(
        TickingPriceRepositoryImpl(), _availableMarketsCubit!);
  }

  _generateFirstDropdown({AvailableMarketsState? marketsState}) {
    if (marketsState is AvailableMarketsLoaded) {
      return ListDropdown(
        title: Strings.marketText,
        hint: const Text(
          Strings.selectMarketText,
        ),
        value: marketsState.selectedMarket,
        items: marketsState.marketsList.map((ActiveSymbols item) {
          return DropdownMenuItem(
            value: item,
            child: Text("${item.marketDisplayName}"),
          );
        }).toList(),
        onChanged: (newValue) {
          _availableMarketsCubit?.selectOneMarket(
              loadedState: marketsState, selectedMarket: newValue);
        },
      );
    }
  }

  Widget _generateSecondDropdown({AvailableMarketsState? marketsState}) {
    if (marketsState is AvailableMarketsLoaded) {
      return ListDropdown(
        title: Strings.symbolText,
        hint: const Text(Strings.selectSymbolText),
        value: marketsState.selectedSymbol,
        items: marketsState.symbolsList.map((ActiveSymbols item) {
          return DropdownMenuItem(
            value: item,
            child: Text("${item.displayName}"),
          );
        }).toList(),
        onChanged: (newValue) {
          _availableMarketsCubit?.selectSymbol(
              loadedState: marketsState, selectedSymbol: newValue);
        },
      );
    }

    return const ListDropdown(
      title: Strings.symbolText,
      hint: Text(Strings.selectSymbolText),
      isLoading: true,
      value: null,
      items: [],
      onChanged: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: Utils.getScreenWidth(context) / 4,
          child: Image.asset(Images.derivLogo),
        ),
      ),
      body: Column(
        children: [
          BlocConsumer<AvailableMarketsCubit, AvailableMarketsState>(
            listener:
                (BuildContext context, AvailableMarketsState marketsState) {
              if (marketsState is AvailableMarketsError) {
                Utils.showSnackBar(
                  context: context,
                  message: marketsState.message,
                );
              }
            },
            builder:
                (BuildContext context, AvailableMarketsState marketsState) {
              if (marketsState is AvailableMarketsInitial) {
                return SizedBox(
                  height: Utils.getScreenHeight(context) / 8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (marketsState is AvailableMarketsLoading) {
                return SizedBox(
                  height: Utils.getScreenHeight(context) / 8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (marketsState is AvailableMarketsLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///generating dropdown for available market
                    _generateFirstDropdown(
                      marketsState: marketsState,
                    ),

                    ///generating dropdown for symbols
                    _generateSecondDropdown(
                      marketsState: marketsState,
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  height: Utils.getScreenHeight(context) / 8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),

          ///showing dynamic price for selected market
          Expanded(
            child: BlocConsumer<TickingPriceCubit, TickingPriceState>(
              bloc: _ticksCubit,
              listener: (BuildContext context, TickingPriceState ticksState) {
                if (ticksState is TickingPriceError) {
                  Utils.showSnackBar(
                    context: context,
                    message: ticksState.message,
                  );
                }
              },
              builder: (BuildContext context, TickingPriceState ticksState) {
                if (ticksState is TickingPriceInitial) {
                  return SizedBox(
                    height: Utils.getScreenHeight(context) / 8,
                    child: const Center(
                      child: Text(
                        Strings.noSymbolsText,
                        style: AppTextStyles
                            .textStyleRegularImageBodySmallWhiteText,
                      ),
                    ),
                  );
                } else if (ticksState is TickingPriceLoading) {
                  return SizedBox(
                    height: Utils.getScreenHeight(context) / 8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (ticksState is TickingPriceLoaded) {
                  return DynamicPriceWidget(
                      tick: ticksState.tick,
                      previousTick: ticksState.previousTick);
                } else {
                  return SizedBox(
                    height: Utils.getScreenHeight(context) / 8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
