import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/storage.dart';

class GlobalController extends GetxController {
  final userRepository = UserRepository();
  final productRepository = ProductRepository();
  // final fcm = FirebaseMessaging.instance;

  final basket = <ProductModel>[];
  final _totalCost = 0.0.obs;
  final _isAddressInRange = true.obs;

  late InitialDataModel _initialDataModel;

  late AddressModel unsavedAddress;

  bool isAddAddressModalOpen = false;

  // void initFireBaseListeners() {
  //   fcm.getToken().then((value) {
  //     if (value != null) {
  //       print("getToken : $value");
  //       saveToken(value);
  //     }
  //   });
  //
  //   fcm.onTokenRefresh.listen((event) {
  //     print("tokenRefreshed : $event");
  //     saveToken(event);
  //   });
  // }

  InitialDataModel get initialDataModel => _initialDataModel;

  set initialDataModel(InitialDataModel value) {
    _initialDataModel = value;
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
        userRepository
            .updateUser(userData)
            .then((value) => value.fold((l) => attemptFailed(l), (r) {
                  initialDataModel.user = r;
                  print(r.fcmToken);
                }));
      }
    }
  }

  void attemptFailed(String message) {
    print(message);
  }

  void updateTotalCost() {
    totalCost = productRepository.calculateTotalCost();
  }
}
