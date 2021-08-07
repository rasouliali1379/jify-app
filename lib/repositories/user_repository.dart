import 'package:dartz/dartz.dart';
import 'package:jify_app/models/user_model.dart';
import 'package:jify_app/network/api_requests.dart';

class UserRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, bool>> singInWithPhoneNumber(String phoneNumber) async {
    final result =
        await _apiRequests.signInByNumber({"mobileNumber": phoneNumber});
    String error = "";

    result.fold((l) {
      error = l;
    }, (r) => null);

    if (error.isEmpty) {
      return const Right(true);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, String>> validateCode(
      String phoneNumber, String code) async {
    final result = await _apiRequests
        .validateCode({"mobileNumber": phoneNumber, "code": code});
    String error = "";
    String token = "";

    result.fold(
        (l) => error = l, (r) => token = r.data["data"]["token"] as String);

    if (token.isNotEmpty) {
      return Right(token);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, UserModel>> updateUser(UserModel user) async {
    final result = await _apiRequests.updateUser(user.toJson());
    String error = "";
    UserModel? userModel;

    result.fold(
        (l) => error = l,
        (r) => userModel =
            UserModel.fromJson(r.data["data"] as Map<String, dynamic>));

    if (userModel != null) {
      return Right(userModel!);
    } else {
      return Left(error);
    }
  }

}
