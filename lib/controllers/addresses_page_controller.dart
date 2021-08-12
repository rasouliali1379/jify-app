import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';

class AddressesPageController extends GetxController {
  final _addressList = <AddressModel>[].obs;
  late String selectedAddress;

  @override
  Future<void> onInit() async {
    populateAddresses();
    super.onInit();
  }

  List<AddressModel> get addressList => _addressList.value;

  set addressList(List<AddressModel> value) {
    _addressList.value = value;
  }

  void populateAddresses() {
    selectedAddress = storageRead(AppKeys.address) as String;
    addressList =
        Get.find<GlobalController>().initialDataModel.user!.addresses!;
  }

  Future<void> onAddressClickHandler(AddressModel addressModel) async {
    await storageWrite(AppKeys.address, addressModel.id);
    Get.find<CheckoutFragmentController>().checkSelectedAddress();
    final globalController = Get.find<GlobalController>();
    globalController.isAddressInRange = addressModel.distance! <=
        globalController.initialDataModel.supportedDistance!;
    Get.back();
  }

  Future<void> openDeliveryAddressPage() async {
    await Get.toNamed(Routes.deliveryAddresses);
    populateAddresses();
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
