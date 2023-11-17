import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_project/bloc/authorization/authorization_bloc.dart';
import 'package:stock_market_project/core/router/app_router_config.dart';
import 'package:stock_market_project/data/repositories/authorization_repository.dart';

import 'bloc/stock_crawler/stock_crawler_bloc.dart';
import 'core/config/http_client_config.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/stock_crawler_repository.dart';
import 'firebase_options.dart';

const webServerKey =
    'AAAAQJpgCU0:APA91bHQqqNEIxQa-By-XYL02dexwUaKEdCVKWO2yhw7oAXMUC7OKznvM6gpBGhFzsfoP_l104eGmQ7xpDha9_ZPpNVE7BdZMuNySabKQ59V7ZDkGrDRoa7s1wl_S4kvnOYIApmdGCXP';
final Dio dio = Dio();
final AppRouter appRouter = AppRouter();

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

const androidChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  description: 'This channel is for important notifications',
  importance: Importance.max,
);

final localNotification = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage? message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  HttpOverrides.global = HttpClientConfig();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StockCrawlerRepository>(
          create: (context) => StockCrawlerRepository(),
        ),
        RepositoryProvider<AuthorizationRepository>(
          create: (context) => AuthorizationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<StockCrawlerBloc>(
            create: (context) => StockCrawlerBloc(
              RepositoryProvider.of<StockCrawlerRepository>(context),
            ),
          ),
          BlocProvider<AuthorizationBloc>(
            create: (context) => AuthorizationBloc(
              RepositoryProvider.of<AuthorizationRepository>(context),
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
