import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_themes.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/navigation/pages.dart';
import 'package:jify_app/navigation/routes.dart';

void main() {
  GetStorage.init().then((value) => runApp(JiffyApp()));
  Get.put(GlobalController(), permanent: true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class JiffyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.routes,
      initialRoute: Routes.splash,
      theme: AppThemes.defaultTheme,
    );
  }
}
