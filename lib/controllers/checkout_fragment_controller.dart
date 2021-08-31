import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
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

class CheckoutFragmentController extends GetxController {
  final mainController = Get.find<MainPageController>();
  final globalController = Get.find<GlobalController>();
  final promoCodeController = TextEditingController();
  final cardNumberController = TextEditingController();
  final promoFocus = FocusNode();
  final _checkoutRepository = CheckoutRepository();
  final _productRepository = ProductRepository();

  final _orders = <CheckoutOrderModel>[].obs;
  // final _selectedAddress = AddressModel().obs;
  final _promoLoadingStatus = false.obs;
  final _loadingStatus = false.obs;
  final _promoCode = PromotionCodeModel().obs;
  final _subtotalPrice = 0.0.obs;
  final _deliveryPrice = 0.0.obs;
  final _promoCodePrice = 0.0.obs;
  final _totalPrice = 0.0.obs;

  @override
  void onInit() {
    populateOrders();
    // checkSelectedAddress();
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

  // AddressModel get selectedAddress => _selectedAddress.value;
  //
  // set selectedAddress(AddressModel value) {
  //   _selectedAddress.value = value;
  // }

  List<CheckoutOrderModel> get orders => _orders.value;

  set orders(List<CheckoutOrderModel> value) {
    _orders.value = value;
  }

  void openAddresses() {
    if (storageExists(AppKeys.token)) {
      Get.toNamed(Routes.addresses, parameters: {"from": "checkout"});
    } else {
      showCustomSnackBar('Login to change the address');
    }
  }

  void openPaymentModal() async {
    // String clientNonce =
    //     "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0";
    //
    // final braintreePayment = BraintreePayment();
    // braintreePayment
    //     .showDropIn(
    //       nonce: clientNonce,
    //       amount: "2.0",
    //       googleMerchantId: "d9s55gfrp6jm3qwj",
    //     )
    //     .then((value) => print(value));
    // Get.bottomSheet(PaymentModal());

    var request = BraintreeDropInRequest(
      tokenizationKey: "sandbox_8hxpnkht_kzdtzv2btm4p7s5j",
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '4.20',
          currencyCode: 'USD',
          billingAddressRequired: false,
          googleMerchantID: "d9s55gfrp6jm3qwj"),
      // paypalRequest: BraintreePayPalRequest(
      //   amount: '4.20',
      //   displayName: 'Example company',
      // ),
    );
    final result = await BraintreeDropIn.start(request);
    if (result != null) {
      print(result.paymentMethodNonce.nonce);
    }

    // final request = BraintreeCreditCardRequest(
    //   cardNumber: '4111111111111111',
    //   expirationMonth: '12',
    //   expirationYear: '2021',
    //   cvv: '123',
    // );
    // final result = await Braintree.tokenizeCreditCard(
    //   "sandbox_8hxpnkht_kzdtzv2btm4p7s5j",
    //   request,
    // );
    // if (result != null) {
    //   print(result.nonce);
    // }
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
    Get.find<HomeFragmentController>().addProductToBasket(product);
    showCustomSnackBar(
        "${_productRepository.countInBasket(product.id!)} item added to basket",
        duration: 1);
  }

  void decreaseAmount(String id) {
    Get.find<HomeFragmentController>().removeFromBasket(id);
  }

  // void checkSelectedAddress() {
  //   if (storageExists(AppKeys.token)) {
  //     final userInfo = globalController.initialDataModel.user;
  //     if (userInfo!.addresses!.isNotEmpty) {
  //       if (storageExists(AppKeys.address)) {
  //         final AddressModel? address = findAddress(
  //             userInfo.addresses!, storageRead(AppKeys.address) as String);
  //
  //         if (address != null) {
  //           selectedAddress = address;
  //         } else {
  //           selectedAddress = userInfo.addresses!.last;
  //           storageWrite(AppKeys.address, userInfo.addresses!.last.id)
  //               .then((value) => null);
  //         }
  //       } else {
  //         selectedAddress = userInfo.addresses!.last;
  //         storageWrite(AppKeys.address, userInfo.addresses!.last.id)
  //             .then((value) => null);
  //       }
  //     }
  //   } else {
  //     if (storageExists(AppKeys.unsavedAddress)) {
  //       final rawAddress = storageRead(AppKeys.unsavedAddress) as String;
  //       selectedAddress = AddressModel.fromJson(jsonDecode(rawAddress));
  //     }
  //   }
  // }

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
      showCustomSnackBar('Enter your promo code');
    }
  }

  void attemptFailed(String message) {
    promoLoadingStatus = false;
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed(PromotionCodeModel promo) {
    promoLoadingStatus = false;
    promoCodeController.text = "";
    promoCode = promo;
    calculatePrices();
    showCustomSnackBar("Promotion applied");
  }

  void calculatePrices() {
    deliveryPrice = globalController.initialDataModel.delivery!;
    double _subtotal = 0.0;
    for (final order in orders) {
      final product = findProduct(order.id!);
      if (product!.off! > 0) {
        _subtotal += product.offPrice! * order.qty!;
      } else {
        _subtotal += product.price! * order.qty!;
      }
    }
    subtotalPrice = _subtotal;

    double _promoCodeDiscount = 0.0;
    if (promoCode.code != null) {
      _promoCodeDiscount = _subtotal * promoCode.value!.toDouble() / 100;
      promoCodePrice = _promoCodeDiscount;
    }
    totalPrice = _subtotal - _promoCodeDiscount + deliveryPrice;
  }

  void checkout() {
    if (storageExists(AppKeys.token)) {
      if (globalController.initialDataModel.isOpen!) {
        if (orders.isNotEmpty) {
          if (globalController.isAddressInRange) {
            promoFocus.unfocus();
            loadingStatus = true;
            final checkoutModel = BasketModel(
                products: orders,
                // address: Address(id: selectedAddress.id),
                promotion: Promotion(code: promoCode.code));
            _checkoutRepository.checkout(checkoutModel).then((value) =>
                value.fold(
                    (l) => attemptFailed(l), (r) => checkoutAttemptSucceed(r)));
          } else {
            showCustomSnackBar("Address not in range");
          }
        } else {
          showCustomSnackBar(
              "You need to add product into your basket to checkout");
        }
      } else {
        showCustomSnackBar(
            "Store is currently closed, you can't submit an order.");
      }
    } else {
      Get.toNamed(Routes.signIn);
    }
  }

  void checkoutAttemptSucceed(CheckoutModel checkoutData) {
    loadingStatus = false;
    Get.toNamed(Routes.confirmation, arguments: checkoutData);
  }

  // void checkUserLogStatus() {
  //   if (storageExists(AppKeys.token)) {
  //     if ((storageRead(AppKeys.token) as String).isNotEmpty) {
  //       loggedIn = true;
  //       populateOrders();
  //       checkSelectedAddress();
  //       return;
  //     }
  //   }
  //   promoCode = PromotionCodeModel();
  //   selectedAddress = AddressModel();
  //   loggedIn = false;
  // }

  void openSignInPage() {
    Get.toNamed(Routes.signIn);
  }

  void startShopping() {
    Get.find<MainPageController>().onBottomNavClickHandler(0);
  }
}
