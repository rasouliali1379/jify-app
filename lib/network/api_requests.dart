import 'package:dio/dio.dart';
import 'package:jify_app/network/api_client.dart';

class ApiRequests {
  final _apiClient = ApiClient();

  Future<Response?> init() async {
    return _apiClient.get('/init', {});
  }

  Future<Response?> contactSupport(Map<String, dynamic> map) async {
    return _apiClient.post('/support/contact', map);
  }

  Future<Response?> signInByNumber(Map<String, dynamic> map) async {
    return _apiClient.post('/user/signInByMobileNumber', map);
  }

  Future<Response?> validateCode(Map<String, dynamic> map) async {
    return _apiClient.post('/user/validatecode', map);
  }

  Future<Response?> signUpByEmail(Map<String, dynamic> map) async {
    return _apiClient.post('/user/signupByEmail', map);
  }

  Future<Response?> signInByEmail(Map<String, dynamic> map) async {
    return _apiClient.post('/user/signinByEmail', map);
  }

  Future<Response?> updateUser(Map<String, dynamic> map) async {
    return _apiClient.post('/user/update', map);
  }

  Future<Response?> forgotPassword(Map<String, dynamic> map) async {
    return _apiClient.post('/user/forgotPassword', map);
  }

  Future<Response?> uuidValidation(String uuid) async {
    return _apiClient.get('/user/forgotPassword/$uuid', {});
  }

  Future<Response?> changePassword(
      String uuid, Map<String, dynamic> map) async {
    return _apiClient.put('/user/forgotPassword/$uuid/ChangePassword', map);
  }

  Future<Response?> getAddresses() async {
    return _apiClient.get('/user/addresses', {});
  }

  Future<Response?> addAddress(Map<String, dynamic> map) async {
    return _apiClient.post('/user/addresses/add', map);
  }

  Future<Response?> getCategories() async {
    return _apiClient.get('/product/category', {});
  }

  Future<Response?> getSubcategories(String id, int page, String search) async {
    return _apiClient
        .get('/product/category/$id', {"page": page, "search": search});
  }

  Future<Response?> getProducts(String search, int page) async {
    return _apiClient.get('/product', {"page": page, "search": search});
  }

  Future<Response?> checkout(Map<String, dynamic> map) async {
    return _apiClient.post('/checkout', map);
  }

  Future<Response?> getCheckout(String id) async {
    return _apiClient.get('/checkout/$id', {});
  }

  Future<Response?> getPromotionCode(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/promotion', map);
  }

  Future<Response?> deletePromotionCode(String id) async {
    return _apiClient.delete('/checkout/$id/promotion', {});
  }

  Future<Response?> addAddressToCheckout(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/address', map);
  }

  Future<Response?> deleteAddressFromCheckout(String id) async {
    return _apiClient.delete('/checkout/$id/address', {});
  }

  Future<Response?> completeCheckout(
      String id, Map<String, dynamic> map) async {
    return _apiClient.post('/checkout/$id/complete', map);
  }

  Future<Response?> getOrders() async {
    return _apiClient.get('/checkout/orders', {});
  }
}
