import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jify_app/network/api_client.dart';
import 'package:jify_app/network/api_client_map.dart';

class ApiRequests {
  final _apiClient = ApiClient();
  final _apiClientMap = ApiClientMap();

  Future<Either<String, Response>> init() async {
    return _apiClient.get('/init', {});
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
    return _apiClient.put('/user/update', map);
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

  Future<Either<String, Response>> updateAddress(
      String id, Map<String, dynamic> map) async {
    return _apiClient.put('/user/addresses/$id', map);
  }

  Future<Either<String, Response>> deleteAddress(String id) async {
    return _apiClient.delete('/user/addresses/$id', {});
  }

  Future<Either<String, Response>> getCategories() async {
    return _apiClient.get('/product/category', {});
  }

  Future<Either<String, Response>> getProductsBySubcategoryId(
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

  Future<Either<String, Response>> checkPromotionCode(
      Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/promotion', map);
  }

  Future<Either<String, Response>> completeCheckout(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/complete', map);
  }

  Future<Either<String, Response>> getOrders() async {
    return _apiClient.get('/checkout/orders', {});
  }

  Future<Either<String, Response>> predictPlaces(String input) async {
    return _apiClientMap.get('/autocomplete/json', {
      "input": input,
      "sessiontoken": "1234567890",
      "components": "country:AU"
    });
  }

  Future<Either<String, Response>> getLatLong(String id) async {
    return _apiClientMap.get('/details/json', {
      "place_id": id,
      "fields": "name,geometry,formatted_address",
    });
  }

  Future<Either<String, Response>> notifyAddress(String id) async {
    return _apiClient.get('/user/addresses/$id/notify', {});
  }
}
