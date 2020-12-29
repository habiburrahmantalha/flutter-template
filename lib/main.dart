import 'dart:async';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/utils/dio.dart';
import 'package:flutter_template/utils/disable_scroll_glow.dart';
import 'package:flutter_template/utils/network_connectivity.dart';
import 'package:flutter_template/utils/router_observer.dart';
import 'package:flutter_template/utils/sharedpreference.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'services/navigation_service.dart';
import 'ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  final appleSignInAvailable = await AppleSignInAvailable.check();
  runZonedGuarded(() {
    runApp(Provider<AppleSignInAvailable>.value(
      value: appleSignInAvailable,
      child: MyApp(),
    ));
  }, (error, stackTrace){
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);

  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final globalScaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    _initCrashlytics();
    DioSingleton.instance.create();
    SharedPreferenceManager.instance.create();
    networkConnectivity.initialise();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness: Brightness.light));

    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: DisableScrollGlow(),
          child: Scaffold(key: globalScaffoldKey, body: child),
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: ColorsX.accent,
        primaryColorDark: ColorsX.accent,
        accentColor: ColorsX.accent,
      ),
      routes: <String, WidgetBuilder>{
        SplashScreen.routeName: (ctx) => SplashScreen(),
//        LoginScreen.routeName: (ctx) => LoginScreen(),
//        OtpScreen.routeName: (ctx) => OtpScreen(),
//        DashboardScreen.routeName: (ctx) => DashboardScreen(),
      },
      home: SplashScreen(),
      navigatorObservers: [RouteObserverX()],
    );
  }

  final _kTestingCrashlytics = true;
// Define an async function to initialize FlutterFire
  Future<void> _initCrashlytics() async {
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };
  }

}


Future portrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);

  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}
