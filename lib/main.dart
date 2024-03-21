import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zenFilter/services/init.dart';
import 'package:zenFilter/services/themes.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:zenFilter/dependencyInjection.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:zenFilter/splashScreen.dart';
// import 'package:zenFilter/pages/website_Block.dart';
// import "package:zenFilter/Dashboard/dashboard.dart";
// import "package:zenFilter/login_signup/loginPage.dart";
// import "package:zenFilter/bridge.dart";

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      kDebugMode &&
      defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  await initialize();
  await Settings.init(cacheProvider: SharePreferenceCache());
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAswp94-5QgNf3vVwxhr9Yvb1lnPH9IxdQ',
        appId: '1:161202107391:android:4234f8ca1bdf2f5e186dca',
        messagingSenderId: '161202107391',
        projectId: 'zenfilter-app',
      ),
    );
  } else {
    await Firebase.initializeApp(); // Initialize Firebase for other platforms
  }

  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.dark,
      home: SplashScreen(),
    );
  }
}
