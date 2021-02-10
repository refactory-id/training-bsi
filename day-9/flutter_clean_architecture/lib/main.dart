import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/framework/di/app_container.dart';
import 'package:flutter_clean_architecture/framework/loggers/cubit_logger.dart';
import 'package:flutter_clean_architecture/ui/features/delivery/delivery_cubit.dart';
import 'package:flutter_clean_architecture/ui/features/delivery/delivery_page.dart';
import 'package:flutter_clean_architecture/ui/features/delivery_cost/delivery_cost_cubit.dart';

void main() {
  if (MyApp.isDebug) Bloc.observer = SimpleBlocObserver();

  AppContainer.inject();

  final injector = AppContainer.injector;

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => DeliveryCubit(injector.get(), injector.get())),
    BlocProvider(create: (_) => DeliveryCostCubit(injector.get())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeliveryPage(),
    );
  }
}
