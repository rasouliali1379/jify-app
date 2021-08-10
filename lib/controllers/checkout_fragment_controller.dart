import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/modals/payment_modal.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/basket_model.dart';
import 'package:jify_app/models/checkout_model.dart';
import 'package:jify_app/models/checkout_order_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/models/promotion_code_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/checkout_repository.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';
import 'package:jify_app/widgets/checkout_orders_list_item.dart';

class CheckoutFragmentController extends GetxController {
  final mainController = Get.find<MainPageController>();
  final globalController = Get.find<GlobalController>();
  final promoCodeController = TextEditingController();
  final cardNumberController = TextEditingController();
  final promoFocus = FocusNode();
  final _productRepository = ProductRepository();
  final _checkoutRepository = CheckoutRepository();

  final _orders = <CheckoutOrderModel>[].obs;
  final _selectedAddress = AddressModel().obs;
  final _promoLoadingStatus = false.obs;
  final _loadingStatus = false.obs;
  final _promoCode = PromotionCodeModel().obs;
  final _subtotalPrice = 0.0.obs;
  final _deliveryPrice = 0.0.obs;
  final _promoCodePrice = 0.0.obs;
  final _totalPrice = 0.0.obs;

  final _loggedIn = false.obs;

  @override
  void onInit() {
    checkUserLogStatus();
    super.onInit();
  }

  double get deliveryPrice => _deliveryPrice.value;

  set deliveryPrice(double value) {
    _deliveryPrice.value = value;
  }

  double get promoCodePrice => _promoCodePrice.value;

  set promoCodePrice(double value) {
    _promoCodePrice.value = value;
  }

  double get subtotalPrice => _subtotalPrice.value;

  set subtotalPrice(double value) {
    _subtotalPrice.value = value;
  }

  double get totalPrice => _totalPrice.value;

  set totalPrice(double value) {
    _totalPrice.value = value;
  }

  PromotionCodeModel get promoCode => _promoCode.value;

  set promoCode(PromotionCodeModel value) {
    _promoCode.value = value;
  }

  bool get promoLoadingStatus => _promoLoadingStatus.value;

  set promoLoadingStatus(bool value) {
    _promoLoadingStatus.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  bool get loggedIn => _loggedIn.value;

  set loggedIn(bool value) {
    _loggedIn.value = value;
  }

  AddressModel get selectedAddress => _selectedAddress.value;

  set selectedAddress(AddressModel value) {
    _selectedAddress.value = value;
  }

  List<CheckoutOrderModel> get orders => _orders.value;

  set orders(List<CheckoutOrderModel> value) {
    _orders.value = value;
  }

  void openDeliveryAddresses() {
    Get.toNamed(Routes.deliveryAddresses);
  }

  void openPaymentModal() {
    Get.bottomSheet(PaymentModal());
  }

  void populateOrders() {
    final products = List<ProductModel>.from(globalController.basket);
    final _tempOrders = <CheckoutOrderModel>[];
    for (final product in products) {
      final orderIndex = findOrder(_tempOrders, product.id!);
      if (orderIndex > -1 && _tempOrders.isNotEmpty) {
        _tempOrders[orderIndex].qty = _tempOrders[orderIndex].qty! + 1;
      } else {
        _tempOrders.add(CheckoutOrderModel(id: product.id, qty: 1));
      }
    }

    orders = _tempOrders;
    calculatePrices();
  }

  int findOrder(List<CheckoutOrderModel> orders, String id) {
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].id == id) {
        return i;
      }
    }

    return -1;
  }

  ProductModel? findProduct(String id) {
    for (final product in globalController.basket) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }

  void increaseAmount(ProductModel product) {
    globalController.basket.add(product);
    populateOrders();
    Get.find<CategoryFragmentController>().update();
  }

  void decreaseAmount(String id) {
    _productRepository.removeProductFromBasket(id);
    populateOrders();
    Get.find<CategoryFragmentController>().update();
  }

  void checkSelectedAddress() {
    final userInfo = globalController.initialDataModel.user;
    if (userInfo!.addresses!.isNotEmpty) {
      if (storageExists(AppKeys.address)) {
        AddressModel? address = findAddress(
            userInfo.addresses!, storageRead(AppKeys.address) as String);

        if (address != null) {
          selectedAddress = address;
        } else {
          selectedAddress = userInfo.addresses!.last;
          storageWrite(AppKeys.address, userInfo.addresses!.last.id)
              .then((value) => null);
        }
      } else {
        selectedAddress = userInfo.addresses!.last;
        storageWrite(AppKeys.address, userInfo.addresses!.last.id)
            .then((value) => null);
      }
    }
  }

  AddressModel? findAddress(List<AddressModel> addresses, String id) {
    for (final address in addresses) {
      if (address.id == id) {
        return address;
      }
    }

    return null;
  }

  void removePromoCode() {
    promoCodeController.text = "";
    promoCode = PromotionCodeModel();
    calculatePrices();
  }

  void checkPromoCode() {
    if (promoCodeController.text.isNotEmpty) {
      promoLoadingStatus = true;
      promoFocus.unfocus();
      _checkoutRepository.checkPromotionCode(promoCodeController.text).then(
          (value) =>
              value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
    } else {
      Utilities.makeCustomToast('Enter your promo code');
    }
  }

  void attemptFailed(String message) {
    promoLoadingStatus = false;
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(PromotionCodeModel promo) {
    promoLoadingStatus = false;
    promoCodeController.text = "";
    promoCode = promo;
    calculatePrices();
    Utilities.makeCustomToast("Promotion applied");
  }

  void calculatePrices() {
    double _subtotal = 0.0;
    for (final order in orders) {
      final product = findProduct(order.id!);
      _subtotal += product!.price! * order.qty!;
    }
    subtotalPrice = _subtotal;

    double _promoCodeDiscount = 0.0;
    if (promoCode.code != null) {
      _promoCodeDiscount = _subtotal * promoCode.value!.toDouble() / 100;
      promoCodePrice = _promoCodeDiscount;
    }
    totalPrice = _subtotal - _promoCodeDiscount;
  }

  void checkout() {
    if (orders.isNotEmpty) {
      promoFocus.unfocus();
      loadingStatus = true;
      _checkoutRepository
          .checkout(BasketModel(
              products: orders,
              address: Address(id: selectedAddress.id),
              promotion: Promotion(code: promoCode.code)))
          .then((value) => value.fold(
              (l) => attemptFailed(l), (r) => checkoutAttemptSucceed(r)));
    } else {
      Utilities.makeCustomToast(
          "You need to add product into your basket to checkout");
    }
  }

  void checkoutAttemptSucceed(CheckoutModel checkoutData) {
    loadingStatus = false;
    Get.toNamed(Routes.confirmation, arguments: checkoutData);
  }

  void checkUserLogStatus() {
    if (storageExists(AppKeys.token)) {
      if ((storageRead(AppKeys.token) as String).isNotEmpty) {
        loggedIn = true;
        populateOrders();
        checkSelectedAddress();
        return;
      }
    }
    promoCode = PromotionCodeModel();
    selectedAddress = AddressModel();
    loggedIn = false;
  }

  void openSignInPage() {
    Get.toNamed(Routes.signIn);
  }
}
