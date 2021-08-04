import 'package:dartz/dartz.dart';
import 'package:jify_app/models/user_model.dart';
import 'package:jify_app/network/api_requests.dart';

class UserRepository {
  final _apiRequests = ApiRequests();

  // Future<Either<String, UserModel>> singInWithPhoneNumber(
  //     String phoneNumber, String code) async {
  //   final result = await _apiRequests
  //       .signInByNumber({"mobileNumber": phoneNumber, "code": code});
  //   String? error;
  //   UserModel? data;
  //
  //   result.fold((l) {
  //     error = l;
  //   }, (r) {
  //     data = UserModel.fromJson(r.data);
  //   });
  //
  //   if (data != null) {
  //     return Right(data!);
  //   } else {
  //     return Left(error!);
  //   }
  // }

  // Future<UserModel> singInWithPhoneNumber(
  //     String phoneNumber, String code) async {
  //   final result = await _apiRequests
  //       .signInByNumber({"mobileNumber": phoneNumber, "code": code});
  //   return UserModel.fromJson(result!.data);
  // }
}
