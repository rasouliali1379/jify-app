import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jify_app/constants/app_variables.dart';

class ApiClientMap {
  final _dio = Dio();

  Future<Either<String, Response>> get(String endPoint, Map<String, dynamic> map) async {
    map["key"] = AppVariables.mapKey;
    Response? _response;
    try {
      _response = await _dio.get(AppVariables.mapUrl + endPoint, queryParameters: map);
      return Right(_response);
    } on DioError catch (e) {
      print(e.toString());
      if (_response != null) {
        if (_response.data is Map<String, dynamic>) {
          final _rawJson = _response.data as Map<String, dynamic>;

          if (_rawJson.containsKey("error_message")) {
            return Left(_rawJson["error_message"] as String);
          }
        }
      }
      return const Left("Something unexpected happened");
    }
  }
}
