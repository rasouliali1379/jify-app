import 'package:dartz/dartz.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/address_prediction_model.dart';
import 'package:jify_app/models/predicted_lat_long_model.dart';
import 'package:jify_app/network/api_requests.dart';

class AddressRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, List<AddressModel>>> addAddress(
      AddressModel address) async {
    final result = await _apiRequests.addAddress(address.toJson());
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["addresses"] as List<dynamic>;

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

  Future<Either<String, List<AddressPredictionModel>>> predictAddress(
      String input) async {
    final result = await _apiRequests.predictPlaces(input);
    String error = "";
    List<AddressPredictionModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["predictions"] as List<dynamic>;

      addresses = List<AddressPredictionModel>.from(
          rawAddresses.map((value) => AddressPredictionModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, PredictedLatLongModel>> getLatLong(String id) async {
    final result = await _apiRequests.getLatLong(id);
    String error = "";
    PredictedLatLongModel? latLong;

    result.fold((l) => error = l, (r) {
      latLong = PredictedLatLongModel.fromJson(r.data["result"]);
    });

    if (latLong != null) {
      return Right(latLong!);
    } else {
      return Left(error);
    }
  }
}
