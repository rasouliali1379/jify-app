import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/expandable_container.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Help Center'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.0453, vertical: Get.height * 0.0344),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Freqently Asked Questions:',
                style: AppTextStyles.extraDarkCyan17Normal500,
              ),
              SizedBox(
                height: Get.height * 0.032,
              ),
              const ExpandableContainer(
                  'System related questions',
                  'Lorem ipsum dolor sit amet,'
                      ' consectetur adipiscing elit.'
                      ' Vivamus phasellus sollicitudin pretium,'
                      ' est id massa turpis accumsan vivamus.'
                      ' Facilisis in accumsan maecenas pellentesque lacus, fermentum.'),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              const ExpandableContainer(
                  'How do I add new credit card',
                  'Lorem ipsum dolor sit amet,'
                      ' consectetur adipiscing elit.'
                      ' Vivamus phasellus sollicitudin pretium,'
                      ' est id massa turpis accumsan vivamus.'
                      ' Facilisis in accumsan maecenas pellentesque lacus, fermentum.'),
            ],
          ),
        ),
      ),
    );
  }
}