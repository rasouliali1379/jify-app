import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/constants/app_status.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/widgets/address_container.dart';
import 'package:jify_app/widgets/banner_item.dart';
import 'package:jify_app/widgets/change_address_container.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';
import 'package:jify_app/widgets/category_grid_item.dart';
import 'package:jify_app/widgets/product_item.dart';
import 'package:jify_app/widgets/subcategory_list.dart';
import 'package:jify_app/widgets/subcategory_products_list.dart';
import 'package:jify_app/widgets/subcategory_row_list.dart';

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
    return GetBuilder<HomeFragmentController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
            controller.onAppBarBackPressed,
            controller.clearSearch,
            controller.searchChangeHandler,
            controller.searchTextController,
            controller.searchFocusNode),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            GetX<GlobalController>(builder: (controller) {
              if (controller.initialDataModel.user != null) {
                if (controller.initialDataModel.user!.addresses!.isNotEmpty) {
                  return controller.isAddressInRange
                      ? AddressContainer(
                          RichText(
                            text: TextSpan(
                                style: AppTextStyles.lightPurple11Normal500,
                                children: [
                                  const TextSpan(text: 'Delivery to '),
                                  TextSpan(
                                      text: _controller.getDeliveryAddress(),
                                      style: AppTextStyles
                                          .lightPurple11Normal500
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline)),
                                  const TextSpan(text: ' within 15 minutes')
                                ]),
                          ),
                        )
                      : ChangeAddressContainer(
                          _controller.mainController.openAddressesPage);
                }
              } else if (storageExists(AppKeys.unsavedAddress)) {
                return controller.isAddressInRange
                    ? AddressContainer(
                        RichText(
                          text: TextSpan(
                              style: AppTextStyles.lightPurple11Normal500,
                              children: [
                                const TextSpan(text: 'Delivery to '),
                                TextSpan(
                                    text: _controller.getDeliveryAddress(),
                                    style: AppTextStyles.lightPurple11Normal500
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline)),
                                const TextSpan(text: ' within 15 minutes')
                              ]),
                        ),
                      )
                    : ChangeAddressContainer(
                        _controller.mainController.openAddressesPage);
              }
              return controller.isAddressInRange
                  ? const SizedBox()
                  : const SizedBox();
            }),
            Builder(builder: (context) {
              switch (controller.pageMode) {
                case "search":
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                          vertical: Get.height * 0.0147),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Get.width / 3,
                        mainAxisExtent: Get.height * 0.29,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: _controller.searchedProducts.length,
                      itemBuilder: (context, index) => ProductItem(
                          controller.searchedProducts[index],
                          controller.addProduct,
                          controller.removeFromBasket,
                          controller.browseProduct,
                          controller.productRepository.countInBasket(
                              _controller.searchedProducts[index].id!)),
                    ),
                  );
                case "subcategory_products":
                  return Expanded(
                    child: Column(
                      children: [
                        Obx(() => SubCategoryRowList(
                            _controller.subCategories,
                            _controller.onSubcategoryItemClickHandler,
                            _controller.selectedSubcategory)),
                        Expanded(
                          child: Obx(() {
                            if (controller.productStatus == AppStatus.loading) {
                              return const Center(
                                child: SpinKitRing(
                                  color: AppColors.blue,
                                ),
                              );
                            } else if (controller.productStatus ==
                                AppStatus.nothingFound) {
                              return const Center(
                                child: Text(
                                  'Nothing to show',
                                  style: AppTextStyles.lightGrey14Normal300,
                                ),
                              );
                            }
                            return SubcategoryProductsList(
                                controller.products,
                                controller.scrollController,
                                controller.addProduct,
                                controller.removeFromBasket,
                                controller.browseProduct,
                                controller.productRepository.countInBasket);
                          }),
                        ),
                      ],
                    ),
                  );
                case "subcategory":
                  return Expanded(
                    child: Column(
                      children: [
                        Obx(() => SubCategoryRowList(
                            _controller.subCategories,
                            _controller.onSubcategoryItemClickHandler,
                            _controller.selectedSubcategory)),
                        Expanded(
                          child: SubcategoryList(
                            controller.subCategories,
                            controller.onSubcategoryItemClickHandler,
                            controller.addProduct,
                            controller.removeFromBasket,
                            controller.browseProduct,
                            controller.productRepository.countInBasket,
                          ),
                        ),
                      ],
                    ),
                  );
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.2093,
                        child: Stack(
                          children: [
                            CarouselSlider(
                                items: _controller.banners
                                    .map((e) => BannerItem(e,
                                        _controller.carouselButtonClickHandler))
                                    .toList(),
                                options: CarouselOptions(
                                  height: Get.height * 0.2093,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  enlargeCenterPage: true,
                                  onPageChanged:
                                      _controller.onCarouselChangeHandler,
                                )),
                            Positioned(
                              bottom: Get.height * 0.0221,
                              right: 0,
                              left: 0,
                              child: Obx(() => DotsIndicator(
                                  position: _controller.carouselIndex,
                                  dotsCount: _controller.banners.length,
                                  decorator: const DotsDecorator(
                                      color: AppColors.lightBlue,
                                      activeSize: Size(6, 6),
                                      size: Size(6, 6),
                                      activeColor: AppColors.white))),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: Get.width * 0.0213,
                            bottom: Get.width * 0.0426,
                            left: Get.width * 0.0426,
                            right: Get.width * 0.0426),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Get.width / 2,
                            childAspectRatio: 165 / 124,
                            crossAxisSpacing: Get.width * 0.0266,
                            mainAxisSpacing: Get.width * 0.0266),
                        itemCount: controller.categoryItems.length,
                        itemBuilder: (context, index) => CategoryGridItem(
                            controller.categoryItems[index].title!,
                            controller.categoryItems[index].image!,
                            controller.onCategoryItemClickHandler,
                            index),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }
}
