import 'package:dartz/dartz.dart';
import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/network/api_requests.dart';

class AppRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, InitialDataModel>> getInitialData() async {
    final result = await _apiRequests.init();
    String? error;
    InitialDataModel? data;
    result.fold((l) {
      error = l;
    }, (r) {
      data = InitialDataModel.fromJson(r.data as Map<String, dynamic>);
    });

    if (data != null) {
      return Right(data!);
    } else {
      return Left(error!);
    }
  }

  Future<Either<String, String>> contactSupport(
      String fullName, String email, String subject, String orderId, String message) async {
    final result = await _apiRequests.contactSupport(
        {"fullname": fullName, "email": email, "subject": subject, "orderId": orderId, "message": message});

    String? error;
    String? data;

    result.fold((l) {
      error = l;
    }, (r) {
      data = r.data["msg"] as String;
    });

    if (data != null) {
      return Right(data!);
    } else {
      return Left(error!);
    }
  }
}
