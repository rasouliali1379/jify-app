import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/constants/app_variables.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final _dio = Dio();

  ApiClient() {
    _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  }

  Future<Either<String, Response>> get(String endPoint, Map<String, dynamic> map) async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.mobile || connectionStatus == ConnectivityResult.wifi) {
      final token = storageRead(AppKeys.token) ?? "";
      Response? _response;
      try {
        _response = await _dio.get('${AppVariables.baseUrl}$endPoint?t=${DateTime.now().millisecondsSinceEpoch}',
            options: Options(headers: {"x-auth-token": token}), queryParameters: map);
        return Right(_response);
      } on DioError catch (e) {
        if (e.response != null) {
          return Left(e.response!.data["msg"] as String);
        }
        return const Left("Something unexpected happened");
      }
    }
    return const Left("You're not connected to Internet."
        " Please check your connection and try again");
  }

  Future<Either<String, Response>> post(String endPoint, Map<String, dynamic> map) async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.mobile || connectionStatus == ConnectivityResult.wifi) {
      final token = storageRead(AppKeys.token) ?? "";
      print(token);
      print(token.toString());
      Response? _response;
      try {
        _response = await _dio.post('${AppVariables.baseUrl}$endPoint?t=${DateTime.now().millisecondsSinceEpoch}',
            options: Options(
              headers: {"x-auth-token": token},
              contentType: "application/json",
            ),
            data: map);
        return Right(_response);
      } on DioError catch (e) {
        if (e.response != null) {
          print(e.response!.data.toString());
          return Left(e.response!.data["msg"] as String);
        }
        return const Left("Something unexpected happened");
      }
    }
    return const Left("You're not connected to Internet."
        " Please check your connection and try again");
  }

  Future<Either<String, Response>> put(String endPoint, Map<String, dynamic> map) async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.mobile || connectionStatus == ConnectivityResult.wifi) {
      final token = storageRead(AppKeys.token) ?? "";
      Response? _response;
      try {
        _response = await _dio.put('${AppVariables.baseUrl}$endPoint?t=${DateTime.now().millisecondsSinceEpoch}',
            options: Options(
              headers: {"x-auth-token": token},
              contentType: "application/json",
            ),
            data: map);
        return Right(_response);
      } on DioError catch (e) {
        if (e.response != null) {
          return Left(e.response!.data["msg"] as String);
        }
        return const Left("Something unexpected happened");
      }
    }

    return const Left("You're not connected to Internet."
        " Please check your connection and try again");
  }

  Future<Either<String, Response>> delete(String endPoint, Map<String, dynamic> map) async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.mobile || connectionStatus == ConnectivityResult.wifi) {
      final token = storageRead(AppKeys.token) ?? "";
      Response? _response;
      try {
        _response = await _dio.delete('${AppVariables.baseUrl}$endPoint?t=${DateTime.now().millisecondsSinceEpoch}',
            options: Options(
              headers: {"x-auth-token": token},
              contentType: "application/json",
            ),
            data: map);
        return Right(_response);
      } on DioError catch (e) {
        if (e.response != null) {
          return Left(e.response!.data["msg"] as String);
        }
        return const Left("Something unexpected happened");
      }
    }

    return const Left("You're not connected to Internet."
        " Please check your connection and try again");
  }
}
