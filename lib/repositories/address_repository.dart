import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/address_prediction_model.dart';
import 'package:jify_app/models/predicted_lat_long_model.dart';
import 'package:jify_app/network/api_requests.dart';

class AddressRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, List<AddressModel>>> addAddress(AddressModel address) async {
    final result = await _apiRequests.addAddress(address.toJson());
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["addresses"] as List<dynamic>;

      addresses = List<AddressModel>.from(rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<AddressModel>>> updateAddress(String id, AddressModel address) async {
    final result = await _apiRequests.updateAddress(id, address.toJson());
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["addresses"] as List<dynamic>;

      addresses = List<AddressModel>.from(rawAddresses.map((value) => AddressModel.fromJson(value)));
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
      final rawAddresses = r.data["data"]["addresses"] as List<Map<String, dynamic>>;

      addresses = List<AddressModel>.from(rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<AddressModel>>> deleteAddress(String id) async {
    final result = await _apiRequests.deleteAddress(id);
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["addresses"] as List<dynamic>;

      addresses = List<AddressModel>.from(rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<AddressPredictionModel>>> predictAddress(String input) async {
    final result = await _apiRequests.predictPlaces(input);
    String error = "";
    List<AddressPredictionModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["predictions"] as List<dynamic>;

      addresses =
          List<AddressPredictionModel>.from(rawAddresses.map((value) => AddressPredictionModel.fromJson(value)));
    });

    if (addresses != null) {
      return Right(addresses!);
    } else {
      return Left(error);
    }
  }

  AddressModel findAddress(List<AddressModel> addresses, String id) {
    for (final address in addresses) {
      if (address.id == id) {
        return address;
      }
    }

    return addresses.last;
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

  Future<Either<String, bool>> notifyAddress(String id) async {
    final result = await _apiRequests.notifyAddress(id);
    String error = "";
    List<AddressModel>? addresses;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["data"]["addresses"] as List<dynamic>;

      addresses = List<AddressModel>.from(rawAddresses.map((value) => AddressModel.fromJson(value)));
    });

    AddressModel? addressModel;

    if (addresses != null) {
      addressModel = findAddress(addresses!, id);
    }

    if (addressModel != null) {
      if (addressModel.notify!) {
        return const Right(true);
      }
      return const Left("Something Unexpected happened");
    } else {
      return Left(error);
    }
  }

  double calculateDistance(LatLng latLng, LatLng storeLocation) {
    const earthRadius = 3958.8;
    final dLat = deg2rad(latLng.latitude - storeLocation.latitude);
    final dLon = deg2rad(latLng.longitude - storeLocation.longitude);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(storeLocation.latitude)) * cos(deg2rad(latLng.latitude)) * sin(dLon / 2) * sin(dLon / 2);
    final curve = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * curve;
  }

  double deg2rad(double deg) {
    return deg * (pi / 180);
  }
}
