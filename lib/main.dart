import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/navigation/pages.dart';
import 'package:jify_app/navigation/routes.dart';

void main() {
  runApp(JiffyApp());
}

class JiffyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.routes,
      initialRoute: Routes.SPLASH,
    );
  }
}
