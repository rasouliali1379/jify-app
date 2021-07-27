import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/widgets/address_container.dart';
import 'package:jify_app/widgets/category_grid_item.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin {
  final _controller = Get.find<HomeFragmentController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AddressContainer(
            RichText(
              text: TextSpan(
                  style: AppTextStyles.lightPurple11Normal500,
                  children: [
                    const TextSpan(text: 'Delivery to '),
                    TextSpan(
                        text: 'Bouazar ST 305',
                        style: AppTextStyles.lightPurple11Normal500
                            .copyWith(decoration: TextDecoration.underline)),
                    const TextSpan(text: ' within 15 minutes')
                  ]),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 135,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(14)),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: 163 / 95,
                  children: [
                    CategoryGridItem('Ice Cream', Colors.cyan,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Biscuits', Colors.deepOrangeAccent,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Drinks', Colors.black12,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Snacks', Colors.blueAccent,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Quick Lauch', Colors.cyan,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Pantry', Colors.deepOrangeAccent,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Pet', Colors.black12,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Baby', Colors.deepPurpleAccent,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Home', Colors.teal,
                        _controller.onCategoryItemClickHandler),
                    CategoryGridItem('Health', Colors.orangeAccent,
                        _controller.onCategoryItemClickHandler)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
