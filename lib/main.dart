import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jify_app/constants/app_themes.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/navigation/pages.dart';
import 'package:jify_app/navigation/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    Get.put(GlobalController(), permanent: true);
    GetStorage.init().then((value) => runApp(JiffyApp()));
  });

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
