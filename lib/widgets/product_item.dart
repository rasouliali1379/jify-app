import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/widgets/add_button.dart';
import 'package:jify_app/widgets/circle_button.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final Function addToBasket;
  final Function removeFromBasket;
  final Function onProductClickHandler;
  final int count;

  const ProductItem(this.product, this.addToBasket, this.removeFromBasket,
      this.onProductClickHandler, this.count);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorTweenController;
  late Animation<Color?> _animation;
  late Animation<Color?> _textColorAnimation;

  bool alreadyDone = false;
  @override
  void initState() {
    _colorTweenController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = ColorTween(begin: AppColors.extraLightBLue, end: AppColors.red)
        .animate(_colorTweenController)
          ..addListener(() {
            setState(() {});
          });
    _textColorAnimation =
        ColorTween(begin: AppTextColors.extraDarkCyan, end: AppColors.red)
            .animate(_colorTweenController)
              ..addListener(() {
                setState(() {});
              });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductItem oldWidget) {
    if (widget.count == widget.product.stock &&
        widget.count != 0 &&
        !alreadyDone) {
      changeColor();
    }

    if (widget.count < widget.product.stock!) {
      alreadyDone = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onProductClickHandler(widget.product),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: Get.width * 0.29,
          height: Get.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _animation.value!, width: 1.2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 4,
              ),
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CachedNetworkImage(
                          width: double.maxFinite,
                          height: Get.height * 0.1,
                          imageUrl: widget.product.image!)),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: widget.product.off! > 0,
                      child: SizedBox(
                        width: Get.width * 0.106,
                        height: Get.width * 0.106,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/discount.svg',
                            ),
                            Center(
                              child: Text(
                                "${widget.product.off!.toStringAsFixed(0)}%",
                                style: AppTextStyles.white13Normal800,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.product.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.darkPurple13Normal300,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.product.off! > 0)
                    Flexible(
                      child: Text(
                        "\$${widget.product.offPrice!.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.darkPurple13Normal700,
                      ),
                    ),
                  if (widget.product.off! > 0)
                    SizedBox(
                      width: Get.width * 0.0213,
                    ),
                  if (widget.product.off! > 0)
                    Flexible(
                      child: Text(
                        "\$${widget.product.price!.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.darkPurple13Normal700.copyWith(
                            color: const Color.fromRGBO(171, 171, 171, 1),
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  if (widget.product.off! == 0)
                    Flexible(
                      child: Text(
                        "\$${widget.product.price!.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.darkPurple13Normal700,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                    width: double.maxFinite,
                    height: Get.height * 0.0369,
                    child: Builder(builder: (context) {
                      if (widget.product.stock == 0) {
                        return Container(
                          height: Get.height * 0.0369,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(72, 72, 72, 0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Back Soon',
                            style: AppTextStyles.white12Normal800,
                          ),
                        );
                      } else if (widget.count > 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleButton(
                              SizedBox(
                                  width: Get.width * 0.08,
                                  height: Get.width * 0.08,
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.green,
                                    size: 20,
                                  )),
                              const Color.fromRGBO(200, 255, 216, 1),
                              () => widget.removeFromBasket(widget.product.id),
                              border:
                                  Border.all(color: AppColors.green, width: 2),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                    color: AppColors.black.withOpacity(0.4))
                              ],
                            ),
                            Text(
                              widget.count.toString(),
                              style: AppTextStyles.extraDarkCyan15Normal400
                                  .copyWith(color: _textColorAnimation.value),
                            ),
                            CircleButton(
                              SizedBox(
                                  width: Get.width * 0.08,
                                  height: Get.width * 0.08,
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 20,
                                  )),
                              AppColors.green,
                              () => widget.addToBasket(widget.product),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                    color: AppColors.black.withOpacity(0.4))
                              ],
                            ),
                          ],
                        );
                      }
                      return AddButton(
                          () => widget.addToBasket(widget.product));
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeColor() {
    _colorTweenController.forward();
    alreadyDone = true;
    Future.delayed(const Duration(seconds: 5))
        .then((value) => _colorTweenController.reverse());
  }

  @override
  void dispose() {
    _colorTweenController.dispose();
    super.dispose();
  }
}
