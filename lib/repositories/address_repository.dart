import 'package:dartz/dartz.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/network/api_requests.dart';

class AddressRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, List<AddressModel>>> addAddress(
      AddressModel address) async {
    final result = await _apiRequests.updateUser(address.toJson());
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses =
          r.data["data"]["addresses"] as List<Map<String, dynamic>>;

      addresses = List<AddressModel>.from(
          rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<AddressModel>>> getAddresses() async {
    final result = await _apiRequests.getAddresses();
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses =
          r.data["data"]["addresses"] as List<Map<String, dynamic>>;

      addresses = List<AddressModel>.from(
          rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }
}
