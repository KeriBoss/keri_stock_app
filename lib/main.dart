import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_project/core/router/app_router_config.dart';
import 'package:stock_market_project/repositories/stock_crawler_repository.dart';

import 'bloc/stock_crawler/stock_crawler_bloc.dart';
import 'core/config/http_client_config.dart';
import 'core/theme/app_theme.dart';

const apiKey = 'AIzaSyAORtYhclWmVTCjaK9-rDJmNx0A4U7O7qY';
final Dio dio = Dio();
final AppRouter appRouter = AppRouter();

// final FirebaseAuth auth = FirebaseAuth.instance;
// final FirebaseFirestore fireStore = FirebaseFirestore.instance;

Future<void> main() async {
  HttpOverrides.global = HttpClientConfig();

  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StockCrawlerRepository>(
          create: (context) => StockCrawlerRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StockCrawlerBloc>(
            create: (context) => StockCrawlerBloc(
              RepositoryProvider.of<StockCrawlerRepository>(context),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: appRouter.config(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
        );
      },
    );
  }
}
