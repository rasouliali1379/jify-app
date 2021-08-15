import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/network/api_requests.dart';

class ProductRepository {
  final _apiRequests = ApiRequests();

  int countInBasket(String id) {
    final globalController = Get.find<GlobalController>();
    final items = <ProductModel>[];
    for (final item in globalController.basket) {
      if (item.id == id) {
        items.add(item);
      }
    }
    return items.length;
  }

  void removeProductFromBasket(String id) {
    final globalController = Get.find<GlobalController>();
    for (int i = 0; i < globalController.basket.length; i++) {
      if (globalController.basket[i].id == id) {
        globalController.basket.removeAt(i);
        break;
      }
    }
  }

  int getProductVariantsCount() {
    final globalController = Get.find<GlobalController>();
    final variants = <String>{};
    for (final item in globalController.basket) {
      variants.add(item.id!);
    }

    return variants.length;
  }

  double calculateTotalCost() {
    final globalController = Get.find<GlobalController>();
    double total = 0.0;

    for (final item in globalController.basket) {
      if (item.off! > 0) {
        total += item.offPrice!;
      } else {
        total += item.price!;
      }
    }

    return total;
  }

  Future<Either<String, List<ProductModel>>> searchProducts(
      String query, int page) async {
    final result = await _apiRequests.getProducts(query, page);
    String error = "";
    List<ProductModel>? products;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["products"] as List<dynamic>;

      products = List<ProductModel>.from(
          rawAddresses.map((value) => ProductModel.fromJson(value)));
    });

    if (products != null) {
      return Right(products!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<ProductModel>>> getProductsBySubCategoryId(
      String id, String query, int page) async {
    final result =
        await _apiRequests.getProductsBySubcategoryId(id, page, query);
    String error = "";
    List<ProductModel>? products;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["products"] as List<dynamic>;

      products = List<ProductModel>.from(
          rawAddresses.map((value) => ProductModel.fromJson(value)));
    });

    if (products != null) {
      return Right(products!);
    } else {
      return Left(error);
    }
  }
}
