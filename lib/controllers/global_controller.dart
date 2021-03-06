import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class GlobalController extends GetxController {
  final userRepository = UserRepository();
  final productRepository = ProductRepository();
  final fcm = FirebaseMessaging.instance;
  final firebaseMessaging = FirebaseMessaging;

  final basket = <ProductModel>[];
  final _totalCost = 0.0.obs;
  final _isAddressInRange = true.obs;

  late InitialDataModel initialDataModel;

  late AddressModel unsavedAddress;

  bool exitAppAllowed = false;

  Future<void> initFireBaseListeners() async {
    fcm.getToken().then((value) {
      if (value != null) {
        saveToken(value);
      }
    });

    fcm.onTokenRefresh.listen((event) {
      saveToken(event);
    });

    final settings = await fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 0,
                channelKey: 'basic_channel',
                title: message.notification!.title,
                body: message.notification!.body));
      });
    }
  }

  double get totalCost => _totalCost.value;

  set totalCost(double value) {
    _totalCost.value = value;
  }

  bool get isAddressInRange => _isAddressInRange.value;

  set isAddressInRange(bool value) {
    _isAddressInRange.value = value;
  }

  void saveToken(String token) {
    if (storageExists(AppKeys.token)) {
      final userData = initialDataModel.user;

      if (userData != null) {
        userData.fcmToken = token;
        userRepository.updateUser(userData).then((value) => value.fold((l) => null, (r) {
              initialDataModel.user = r;
            }));
      }
    }
  }

  void updateTotalCost() {
    totalCost = productRepository.calculateTotalCost();
  }

  void exitApp() {
    if (exitAppAllowed) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      }
    } else {
      showCustomSnackBar("Tap again if you want to quit app");
      exitAppAllowed = true;
      Future.delayed(const Duration(seconds: 4)).then((_) => exitAppAllowed = false);
    }
  }
}
