import 'package:get/get.dart';
import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/repositories/product_repository.dart';

class GlobalController extends GetxController {
  final productRepository = ProductRepository();

  final basket = <ProductModel>[];
  final _totalCost = 0.0.obs;

  late InitialDataModel _initialDataModel;

  InitialDataModel get initialDataModel => _initialDataModel;

  set initialDataModel(InitialDataModel value) {
    _initialDataModel = value;
  }

  double get totalCost => _totalCost.value;

  set totalCost(double value) {
    _totalCost.value = value;
  }

  void updateTotalCost() {
    totalCost = productRepository.calculateTotalCost();
  }
}
