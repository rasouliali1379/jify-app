import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/utilities/storage.dart';

class AddressesPageController extends GetxController {
  late List<AddressModel> addressList;
  late String selectedAddress;

  @override
  Future<void> onInit() async {
    selectedAddress = storageRead(AppKeys.address) as String;
    addressList =
        Get.find<GlobalController>().initialDataModel.user!.addresses!;
    super.onInit();
  }

  Future<void> onAddressClickHandler(String id) async {
    await storageWrite(AppKeys.address, id);
    Get.find<AccountInformationPageController>().checkSelectedAddress();
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
