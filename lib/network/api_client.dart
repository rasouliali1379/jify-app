import 'package:dio/dio.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/constants/app_variables.dart';
import 'package:jify_app/utilities/storage.dart';

class ApiClient {
  final _dio = Dio();

  Future<Response?> get(String endPoint, Map<String, dynamic> map) async {
    try {
      final token = storageRead(AppKeys.token) ?? "";
      return await _dio.get(AppVariables.baseUrl + endPoint,
          options: Options(headers: {"x-auth-token": token}),
          queryParameters: map);
    } on DioError catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Response?> post(String endPoint, Map<String, dynamic> map) async {
    try {
      final token = storageRead(AppKeys.token) ?? "";
      return await _dio.post(AppVariables.baseUrl + endPoint,
          options: Options(
            headers: {"x-auth-token": token},
            contentType: "application/json",
          ),
          data: map);
    } on DioError catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Response?> put(String endPoint, Map<String, dynamic> map) async {
    try {
      final token = storageRead(AppKeys.token) ?? "";
      return await _dio.put(AppVariables.baseUrl + endPoint,
          options: Options(
            headers: {"x-auth-token": token},
            contentType: "application/json",
          ),
          data: map);
    } on DioError catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Response?> delete(String endPoint, Map<String, dynamic> map) async {
    try {
      final token = storageRead(AppKeys.token) ?? "";
      return await _dio.delete(AppVariables.baseUrl + endPoint,
          options: Options(
            headers: {"x-auth-token": token},
            contentType: "application/json",
          ),
          data: map);
    } on DioError catch (e) {
      print(e.toString());
    }
    return null;
  }
}
