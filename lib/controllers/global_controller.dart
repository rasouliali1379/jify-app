import 'package:get/get.dart';
import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/models/product_model.dart';

class GlobalController extends GetxController {

  final basket = <ProductModel>[];

  late InitialDataModel _initialDataModel;

  InitialDataModel get initialDataModel => _initialDataModel;

  set initialDataModel(InitialDataModel value) {
    _initialDataModel = value;
  }
}
