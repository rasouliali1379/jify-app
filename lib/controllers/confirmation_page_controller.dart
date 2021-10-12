import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/enums/payment_enum.dart';
import 'package:jify_app/modals/add_card_modal.dart';
import 'package:jify_app/modals/payment_method_modal.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/card_model.dart';
import 'package:jify_app/models/checkout_model.dart';
import 'package:jify_app/models/delivery_model.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/models/promotion_code_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/repositories/card_repository.dart';
import 'package:jify_app/repositories/checkout_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';
import 'package:pay/pay.dart';

class ConfirmationPageController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final mapCompleter = Completer<GoogleMapController>();

  final noteTextController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cvcNumberController = TextEditingController();
  final expireDateController = TextEditingController();

  final cardNumberFocus = FocusNode();
  final cvcNumberFocus = FocusNode();
  final expireDateFocus = FocusNode();

  final checkoutRepository = CheckoutRepository();
  final _addressRepository = AddressRepository();
  final _cardRepository = CardRepository();

  final _selectedOption = 0.obs;
  // final _selectedSchedule = "".obs;
  final _loadingStatus = false.obs;
  final _selectedAddress = AddressModel().obs;
  final _paymentMethod = (Payment.apple).obs;

  final cameraPosition = const CameraPosition(
    target: LatLng(-35.282001, 149.128998),
    zoom: 14.4746,
  );

  late GoogleMapController mapController;
  OrderModel? orderModel;
  final _checkoutData = CheckoutModel().obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Payment get paymentMethod => _paymentMethod.value;

  set paymentMethod(Payment value) {
    _paymentMethod.value = value;
  }

  AddressModel get selectedAddress => _selectedAddress.value;

  set selectedAddress(AddressModel value) {
    _selectedAddress.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  // String get selectedSchedule => _selectedSchedule.value;
  //
  // set selectedSchedule(String value) {
  //   _selectedSchedule.value = value;
  // }

  CheckoutModel get checkoutData => _checkoutData.value;

  set checkoutData(CheckoutModel value) {
    _checkoutData.value = value;
  }

  int get selectedOption => _selectedOption.value;

  set selectedOption(int value) {
    _selectedOption.value = value;
  }

  // void openSchedule() {
  //   Get.toNamed(Routes.schedule, preventDuplicates: true)!
  //       .then((value) => selectedSchedule = value as String);
  // }

  Function() onOptionClickHandler(int index) {
    return () {
      selectedOption = index;
    };
  }

  void onMapCreated(GoogleMapController controller) {
    mapCompleter.complete(controller);
    mapController = controller;
  }

  void getData() {
    checkoutData = Get.arguments as CheckoutModel;
    checkSelectedAddress();
    getPaymentMethod();
  }

  void checkSelectedAddress() {
    selectedAddress = _addressRepository.findAddress(
        globalController.initialDataModel.user!.addresses!, storageRead(AppKeys.address) as String);
    selectedOption = getOptionIndex(selectedAddress.options!);
    noteTextController.text = selectedAddress.note!;
    mapCompleter.future.then((value) => value.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              selectedAddress.location!.coordinates![0] as double, selectedAddress.location!.coordinates![1] as double),
          zoom: 14.4746,
        ))));
  }

  String getDeliveryAddress(String address) {
    if (address.length > 30) {
      return '${address.substring(0, 30)}...';
    }
    return address;
  }

  String getOption(int index) {
    String option = "Meet outside";

    switch (index) {
      case 0:
        option = "Leave at door";
        break;
      case 1:
        option = "Meet at door";
        break;
    }
    return option;
  }

  int getOptionIndex(String option) {
    int index = 2;

    switch (option) {
      case "Leave at door":
        index = 0;
        break;
      case "Meet at door":
        index = 1;
        break;
    }
    return index;
  }

  Future<void> placeOrder() async {
    if (globalController.isAddressInRange) {
      loadingStatus = true;

      String? paymentToken;

      if (paymentMethod == Payment.apple || paymentMethod == Payment.google) {
        final _paymentItems = [
          PaymentItem(
            label: 'Total',
            amount: checkoutData.checkout!.amount!.total!.toString(),
            status: PaymentItemStatus.final_price,
          )
        ];
        final Pay _payClient =
            Pay.withAssets(['default_payment_profile_google_pay.json', 'default_payment_profile_apple_pay.json']);
        switch (paymentMethod) {
          case Payment.apple:
            final userCanPay = await _payClient.userCanPay(PayProvider.apple_pay);
            if (userCanPay) {
              try {
                final result = await _payClient.showPaymentSelector(paymentItems: _paymentItems);
                paymentToken = result['paymentMethodData']['token'].toString();
              } catch (e) {
                print(e.toString());
              }
            }
            break;
          case Payment.google:
            // final userCanPay = await _payClient.userCanPay(PayProvider.google_pay);

            if (true) {
              try {
                final result = await _payClient.showPaymentSelector(paymentItems: _paymentItems);
                paymentToken = result['paymentMethodData']['token'].toString();
              } catch (e) {
                print(e.toString());
              }
            }
            break;
          case Payment.card:
            break;
        }
        if (paymentToken == null) {
          showCustomSnackBar("Payment Failed");
          loadingStatus = false;
          return;
        }
      }

      checkoutRepository
          .completeCheckout(
              checkoutData.checkout!.id!,
              DeliveryModel(
                  note: noteTextController.text.isEmpty ? null : noteTextController.text,
                  options: getOption(selectedOption)),
              AddressModel(id: selectedAddress.id),
              paymentToken: paymentToken)
          .then((value) => value.fold((l) => attemptFailed(l), (r) => orderSubmissionAttemptSucceed(r)));
    } else {
      showCustomSnackBar("Address not in range");
    }
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void orderSubmissionAttemptSucceed(OrderModel order) {
    loadingStatus = false;
    orderModel = order;
    clearBasket();
    Get.back();
  }

  Future<void> payOrder() async {
    loadingStatus = true;
    // final request = BraintreeDropInRequest(
    //   tokenizationKey: 'sandbox_q7sjs89q_d9s55gfrp6jm3qwj',
    //   clientToken: "sandbox_q7sjs89q_d9s55gfrp6jm3qwj",
    //   collectDeviceData: true,
    //   vaultManagerEnabled: true,
    //   googlePaymentRequest: BraintreeGooglePaymentRequest(
    //     totalPrice: orderModel!.amount!.total.toString(),
    //     currencyCode: 'USD',
    //     billingAddressRequired: false,
    //   ),
    //   applePayRequest: BraintreeApplePayRequest(
    //       amount: orderModel!.amount!.total!,
    //       appleMerchantID: "",
    //       countryCode: "",
    //       currencyCode: "USD",
    //       displayName: ""),
    //   paypalRequest: BraintreePayPalRequest(
    //       amount: orderModel!.amount!.total.toString(),
    //       displayName: 'Example company',
    //       currencyCode: "USD",
    //       billingAgreementDescription: "I accept"),
    // );
    //
    // final result = await BraintreeDropIn.start(request);
    //
    // if (result != null) {
    //   print("nonce : ${result.paymentMethodNonce.nonce}");
    //   print("device-data : ${result.deviceData}");
    //   print("description : ${result.paymentMethodNonce.description}");
    //   print("orderID : ${orderModel!.id!}");
    //
    //   checkoutRepository
    //       .pay(result.paymentMethodNonce.nonce, result.deviceData!.toString(), orderModel!.id!,
    //           result.paymentMethodNonce.description, 0)
    //       .then((result) => result.fold((l) => attemptFailed(l), (r) => paymentAttemptSucceed()));
    // } else {
    //   loadingStatus = false;
    //   showCustomSnackBar("Your payment could not be processed");
    // }
  }

  void paymentAttemptSucceed() {
    loadingStatus = false;

    showCustomSnackBar("Your payment has been processed successfully");
  }

  Future<void> clearBasket() async {
    globalController.basket.clear();
    final checkoutController = Get.find<CheckoutFragmentController>();
    checkoutController.populateOrders();
    checkoutController.promoCode = PromotionCodeModel();
    Get.find<MainPageController>().onBottomNavClickHandler(2);
    Get.find<OrdersFragmentController>().getOrderList();
    Get.find<GlobalController>().updateTotalCost();
    Get.find<HomeFragmentController>().update();
    await storageRemove(AppKeys.orders);
  }

  void openAddressesPage() {
    Get.toNamed(Routes.addresses)?.then((value) => checkSelectedAddress());
  }

  void openPaymentModal() {
    Get.bottomSheet(PaymentMethodModal());
  }

  void openAddCardModal() {
    Get.bottomSheet(AddCardModal()).then((_) => clearCardModal());
  }

  void onPaymentMethodClickHandler(Payment payment) {
    storageWrite(AppKeys.payment, payment.name).then((_) {
      paymentMethod = payment;
      Get.back();
    });
  }

  void getPaymentMethod() {
    final payment = storageRead(AppKeys.payment);
    if (payment != null && globalController.initialDataModel.user!.card != null) {
      paymentMethod = findPaymentByName(payment as String);
    } else {
      if (Platform.isAndroid) {
        paymentMethod = Payment.google;
      } else {
        paymentMethod = Payment.apple;
      }
    }
  }

  Payment findPaymentByName(String name) {
    for (final method in Payment.values) {
      if (method.name == name) {
        return method;
      }
    }
    return Payment.values.last;
  }

  void clearCardModal() {
    cardNumberController.clear();
    cvcNumberController.clear();
    expireDateController.clear();
  }

  void cardNumberChangeHandler(String value) {
    if (value.length > 18) {
      expireDateFocus.requestFocus();
    }
  }

  void cvcNumberChangeHandler(String value) {
    if (value.length == 3) {
      cvcNumberFocus.unfocus();
    }
  }

  void expireDateChangeHandler(String value) {
    if (value.length > 4) {
      cvcNumberFocus.requestFocus();
    }
  }

  void addNewCard() {
    if (cardNumberController.text.isNotEmpty) {
      final cardNumber = cardNumberController.text.replaceAll(' ', '');

      if (cardNumber.length == 16) {
        if (expireDateController.text.isNotEmpty) {
          final expirationDate = expireDateController.text.replaceAll('/', '');
          if (expirationDate.length == 4) {
            if (cvcNumberController.text.isNotEmpty) {
              final cvc = cvcNumberController.text;
              if (cvc.length == 3) {
                loadingStatus = true;
                _cardRepository
                    .updateCard(CardModel(
                        cardHolderName: 'This is me',
                        cardNumber: cardNumber,
                        expireDateMonth: int.parse(expirationDate.substring(0, 2)),
                        expireDateYear: int.parse(expirationDate.substring(2))))
                    .then((result) => result.fold((l) => attemptFailed(l), (r) => addCardAttemptSucceed(r)));
              } else {
                showCustomSnackBar('Invalid CVC/CVV number');
              }
            } else {
              showCustomSnackBar('CVC/CVV number required');
            }
          } else {
            showCustomSnackBar('Invalid expiration date');
          }
        } else {
          showCustomSnackBar('Expiration date required');
        }
      } else {
        showCustomSnackBar('Invalid card number');
      }
    } else {
      showCustomSnackBar('Card number required');
    }
  }

  void addCardAttemptSucceed(CardModel r) {
    loadingStatus = false;
    storageWrite(AppKeys.payment, 'card').then((_) {
      globalController.initialDataModel.user!.card = r;
      paymentMethod = Payment.card;
      Get.back();
    });
  }
}
