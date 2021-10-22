import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moto_365/main_app.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'dart:async';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/providers/map_provider.dart';
import './providers/productrs_provider.dart';
import './providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:bugsnag_crashlytics/bugsnag_crashlytics.dart';

import './providers/services_provider.dart';

void main() {
  // BugsnagCrashlytics.instance.register(
  //     androidApiKey: "2881ddbdacb389eec8530635547f4c51",
  //     iosApiKey: "2881ddbdacb389eec8530635547f4c51",
  //     releaseStage: '1.0',
  //     appVersion: '1.0');
  // FlutterError.onError = BugsnagCrashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

 
    runApp(MyApp());
  

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, MapProvider>(
          update: (ctx, auth, _) => MapProvider(
            auth.token,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, _) => Products(
            auth.token,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, Services>(
          update: (ctx, auth, _) => Services(
            auth.token,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, Cart>(
          update: (ctx, auth, _) => Cart(auth.token),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, ForumProvider>(
          update: (ctx, auth, _) => ForumProvider(
            auth.token,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, ClubProvider>(
          update: (ctx, auth, _) => ClubProvider(
            auth.token,
          ),
          create: null,
        ),
      ],
      child: MainApp(),
    );
  }
}
