import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_themes.dart';
import 'package:jify_app/navigation/pages.dart';
import 'package:jify_app/navigation/routes.dart';

main() async {
  await GetStorage.init();
  runApp(JiffyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.white,
      statusBarColor: Colors.transparent));
}

class JiffyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.routes,
      initialRoute: Routes.SPLASH,
      theme: AppThemes.defaultTheme,
    );
  }
}
