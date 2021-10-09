import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_up/assets/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/router.dart';
import 'services/init_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Starter Kit.',
      theme: appTheme,
      locale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: pages,
    );
  }
}
