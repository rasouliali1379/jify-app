import 'package:get/get.dart';
import 'package:jify_app/controllers/global_controller.dart';

enum Payment { apple, google, card }

extension PaymentExtention on Payment {
  String get name {
    switch (this) {
      case Payment.apple:
        return 'Apple Pay';
      case Payment.google:
        return 'Google Pay';
      case Payment.card:
        return '**** **** **** ${Get.find<GlobalController>().initialDataModel.user!.card!.cardNumber!}';
    }
  }

  String get icon {
    switch (this) {
      case Payment.apple:
        return 'assets/icons/apple_logo.svg';
      case Payment.google:
        return 'assets/icons/google.svg';
      case Payment.card:
        return 'assets/icons/master.svg';
    }
  }
}
