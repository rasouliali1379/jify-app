import 'package:flutter/cupertino.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class OrdersList extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const OrdersList(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 21),
          child: Text(title, style: AppTextStyles.extraDarkCyan19Normal500,),
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: items,
        )
      ],
    );
  }
}
