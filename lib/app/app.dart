import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/available_markets_cubit.dart';
import '../data/repos/active_symbols_repository_impl.dart';
import '../routes/app_routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvailableMarketsCubit>(
          create: (BuildContext context) =>
              AvailableMarketsCubit(ActiveSymbolsRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,

        ///home is commented because flutter will automatically fetch the route with name "/" defined in route_names
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
