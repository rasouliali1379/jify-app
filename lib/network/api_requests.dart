import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jify_app/network/api_client.dart';

class ApiRequests {
  final _apiClient = ApiClient();

  Future<Either<String, Response>> init() async {
    return _apiClient.get('/inite', {});
  }

  Future<Either<String, Response>> contactSupport(
      Map<String, dynamic> map) async {
    return _apiClient.post('/support/contact', map);
  }

  Future<Either<String, Response>> signInByNumber(
      Map<String, dynamic> map) async {
    return _apiClient.post('/user/signInByMobileNumber', map);
  }

  Future<Either<String, Response>> validateCode(
      Map<String, dynamic> map) async {
    return _apiClient.post('/user/validatecode', map);
  }

  Future<Either<String, Response>> signUpByEmail(
      Map<String, dynamic> map) async {
    return _apiClient.post('/user/signupByEmail', map);
  }

  Future<Either<String, Response>> signInByEmail(
      Map<String, dynamic> map) async {
    return _apiClient.post('/user/signinByEmail', map);
  }

  Future<Either<String, Response>> updateUser(Map<String, dynamic> map) async {
    return _apiClient.post('/user/update', map);
  }

  Future<Either<String, Response>> forgotPassword(
      Map<String, dynamic> map) async {
    return _apiClient.post('/user/forgotPassword', map);
  }

  Future<Either<String, Response>> uuidValidation(String uuid) async {
    return _apiClient.get('/user/forgotPassword/$uuid', {});
  }

  Future<Either<String, Response>> changePassword(
      String uuid, Map<String, dynamic> map) async {
    return _apiClient.put('/user/forgotPassword/$uuid/ChangePassword', map);
  }

  Future<Either<String, Response>> getAddresses() async {
    return _apiClient.get('/user/addresses', {});
  }

  Future<Either<String, Response>> addAddress(Map<String, dynamic> map) async {
    return _apiClient.post('/user/addresses/add', map);
  }

  Future<Either<String, Response>> getCategories() async {
    return _apiClient.get('/product/category', {});
  }

  Future<Either<String, Response>> getSubcategories(
      String id, int page, String search) async {
    return _apiClient
        .get('/product/category/$id', {"page": page, "search": search});
  }

  Future<Either<String, Response>> getProducts(String search, int page) async {
    return _apiClient.get('/product', {"page": page, "search": search});
  }

  Future<Either<String, Response>> checkout(Map<String, dynamic> map) async {
    return _apiClient.post('/checkout', map);
  }

  Future<Either<String, Response>> getCheckout(String id) async {
    return _apiClient.get('/checkout/$id', {});
  }

  Future<Either<String, Response>> getPromotionCode(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/promotion', map);
  }

  Future<Either<String, Response>> deletePromotionCode(String id) async {
    return _apiClient.delete('/checkout/$id/promotion', {});
  }

  Future<Either<String, Response>> addAddressToCheckout(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/address', map);
  }

  Future<Either<String, Response>> deleteAddressFromCheckout(String id) async {
    return _apiClient.delete('/checkout/$id/address', {});
  }

  Future<Either<String, Response>> completeCheckout(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/complete', map);
  }

  Future<Either<String, Response>> getOrders() async {
    return _apiClient.get('/checkout/orders', {});
  }
}
