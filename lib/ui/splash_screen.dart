import 'dart:async';

import 'package:deriv_price_tracker/constants/colors.dart';
import 'package:deriv_price_tracker/constants/strings.dart';
import 'package:deriv_price_tracker/routes/route_names.dart';
import 'package:deriv_price_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/available_markets_cubit.dart';
import '../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AvailableMarketsCubit? _marketsCubit;

  ///after certain timeout the home screen will load
  _startTimeout() async {
    return Timer(const Duration(milliseconds: 1800), () {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.homeScreen,
        arguments: Strings.homeScreenText,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _startTimeout();

    ///Loading data for available markets drop down
    _marketsCubit = BlocProvider.of<AvailableMarketsCubit>(context);
    _marketsCubit?.getAvailableMarkets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      bottom: true,
      right: true,
      child: Scaffold(
        backgroundColor: ColorPalette.colorBlack,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Utils.getScreenHeight(context) / 4,
                width: Utils.getScreenWidth(context) / 1.5,
                child: Image.asset(
                  Images.derivLogo,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: Utils.getScreenHeight(context) / 20,
                child: const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
