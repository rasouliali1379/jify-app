import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/utilities/storage.dart';

class AddressesPageController extends GetxController {
  int selectedAddress = 0;

  @override
  Future<void> onInit() async {
    selectedAddress = storageRead(AppKeys.address) as int;
    super.onInit();
  }

  Future<void> onAddressClickHandler(int index) async {
    await storageWrite(AppKeys.address, index);
    Get.back();
  }

  String getIcon(String type) {
    switch (type) {
      case 'home':
        return 'assets/icons/home.svg';
      case 'office':
        return 'assets/icons/briefcase.svg';
      case 'gym':
        return 'assets/icons/dumbells.svg';
      case 'custom':
        return 'assets/icons/location_tall.svg';
    }
    return '';
  }
}
