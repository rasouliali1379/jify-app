import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/help_center_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/expandable_container.dart';
import 'package:jify_app/widgets/long_button.dart';

class HelpCenterPage extends GetView<HelpCenterPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomToolBar('Help Centere'),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: Get.height * 0.0344),
            children: [
              const Text(
                'Freqently Asked Questions:',
                style: AppTextStyles.extraDarkCyan17Normal500,
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04, bottom: Get.height * 0.025),
                child: const Text(
                  'About Jify',
                  style: AppTextStyles.blue16Normal500,
                ),
              ),
              ExpandableContainer(
                  'What is Jify?',
                  'From snacks & drinks to cleaning products & home essentials.'
                      ' Hundreds of items are available to be delivered straight to your doorstep in minutes.'
                      ' We operate our hyperlocal warehouses in neighbourhoods across Australia and will deliver'
                      ' to you in as little as 15 minutes, we’re only ever a Jify away.',
                  Get.height * 0.222),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'What type of products does Jify sell?',
                  'Our products available will continue to grow, so far consisting of; Drinks (non-alcoholic),'
                      ' Snacks & Confectionary, Quick Meals, Ice Cream, Pantry items, Dairy & Deli products,'
                      ' Home essentials, Health products, Baby products and Pet essentials.',
                  Get.height * 0.198),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'Where do you deliver?',
                  'Jify is currently delivering to selected suburbs in Melbourne and will be expanding'
                      ' rapidly throughout Victoria and interstate in the near future.'
                      ' To see if you’re eligible for delivery simply enter your delivery address,'
                      ' if we’re not currently in your area you can select to be notified once we'
                      ' are and be the first to know.',
                  Get.height * 0.222),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'How does it work?',
                  'Simply add your delivery address,'
                      ' sign up for an account and begin adding products from our large range to your cart.'
                      ' Place the order and it will be sent to your local Jify store/warehouse,'
                      ' where it will be assigned to a delivery driver, arriving at your doorstep in minutes.',
                  Get.height * 0.2),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'How does it work?',
                  'Simply add your delivery address,'
                      ' sign up for an account and begin adding products from our large range to your cart.'
                      ' Place the order and it will be sent to your local Jify store/warehouse,'
                      ' where it will be assigned to a delivery driver, arriving at your doorstep in minutes.',
                  Get.height * 0.2),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer('What are your operating hours?',
                  'We currently aim to operate between 4:30pm to 12am every night.', Get.height * 0.13),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'How long does delivery take?',
                  'Delivery may arrive in a soon as 10-15 minutes,'
                      ' we aim to deliver to all Jify customers within 25 minutes.',
                  Get.height * 0.13),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'Is there a delivery fee?',
                  'There is a small delivery fee which will be displayed at the checkout (promotional free delivery may apply).',
                  Get.height * 0.13),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'Can I schedule a time for delivery?',
                  'We don’t currently offer the option to schedule a time for delivery.'
                      ' You can place an order during our opening hours, and we will be there in a Jify.',
                  Get.height * 0.155),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                  'Can I schedule a time for delivery?',
                  'We don’t currently offer the option to schedule a time for delivery.'
                      ' You can place an order during our opening hours, and we will be there in a Jify.',
                  Get.height * 0.155),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04, bottom: Get.height * 0.025),
                child: const Text(
                  'My Account',
                  style: AppTextStyles.blue16Normal500,
                ),
              ),
              ExpandableContainer(
                'I am unable to log in to my account, what should I do?',
                'I am sure you have double checked your phone number you are entering,'
                    ' if you are still unable to get into your account you can contact us by'
                    ' filling out the contact us form on the app or by emailing us at support@jify.com.au.',
                Get.height * 0.208,
                collapsedHeight: Get.height * 0.08,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                'How do I update my personal details and delivery address?',
                'You can update all your personal details,'
                    ' contact details and delivery address’ on the Account Information page,'
                    ' accessible by hitting the head & shoulders icon in the navigation menu.',
                Get.height * 0.185,
                collapsedHeight: Get.height * 0.08,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04, bottom: Get.height * 0.025),
                child: const Text(
                  'My Orders',
                  style: AppTextStyles.blue16Normal500,
                ),
              ),
              ExpandableContainer(
                'Where is my Order?',
                'If your order is showing as ‘In progress’ it hasn’t left our store just yet,'
                    ' rest assured we are doing our best to get it out with a driver as soon as possible!\n\n'
                    'If your order is showing as ‘On its way’ it is with the delivery driver,'
                    ' who will be doing their best to deliver your order safely in a timely manner.\n\n'
                    'If your order is marked as ‘Complete’ your order should be at your front door.'
                    ' If it is not contact us straight away by filling out the contact us form on the app or email'
                    ' us at support@jify.com.au.',
                Get.height * 0.36,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                'An item is missing, expired or damaged?',
                'If an item is missing, expired or damaged,'
                    ' contact us immediately at using the contact us page on the app and selecting the subject'
                    ' ‘Issue with order’, entering your order number and describing the issue with the order,'
                    ' or email us at support@jify.com.au.',
                Get.height * 0.2,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                'Do you have contact-free delivery?',
                'Yes, orders will be set as ‘Leave at door’ by default, which can be changed in the My Address’'
                    ' page or make a one-time alteration on the Order Confirmation page.'
                    ' You will receive a notification and text message when your order has arrived at your door.',
                Get.height * 0.2,
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04, bottom: Get.height * 0.025),
                child: const Text(
                  'Payments',
                  style: AppTextStyles.blue16Normal500,
                ),
              ),
              ExpandableContainer(
                'What payment methods do you except?',
                'We have really tried to cover all bases in terms of payment methods,'
                    ' as we know you all have different preferences for your online transactions.'
                    ' We currently securely offer Paypal, Debit/Credit card, Apple Pay and Google Pay',
                Get.height * 0.2,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                'How do I update my payment method?',
                'We don’t store your payment details within our app,'
                    ' they are securely stored within the payment gateway.'
                    ' If you would like to use a different payment method or update the payment details,'
                    ' simply do so at Checkout. After you hit ‘Place Order’,'
                    ' you will be able to select your preferred payment method and/or update its details.',
                Get.height * 0.25,
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              ExpandableContainer(
                'How can I redeem a voucher/promotional code?',
                'See Promotions page for all details on current promotions and how they can be redeemed.',
                Get.height * 0.139,
                collapsedHeight: Get.height * 0.08,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.0197,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: Get.height * 0.0344),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: LongButton(controller.openContactUsModal, 'Contact Us', Get.width, Get.height * 0.064)),
          ),
        ],
      ),
    );
  }
}
