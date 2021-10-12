import 'package:dartz/dartz.dart';
import 'package:jify_app/models/card_model.dart';
import 'package:jify_app/network/api_requests.dart';

class CardRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, List<CardModel>>> getCards() async {
    final result = await _apiRequests.getCards();
    String error = "";
    List<CardModel>? cards;

    result.fold((l) => error = l, (r) {
      final rawAddresses = r.data["cards"] as List<dynamic>;

      cards = List<CardModel>.from(rawAddresses.map((value) => CardModel.fromJson(value)));
    });

    if (cards != null) {
      return Right(cards!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, List<CardModel>>> deleteCard(String id) async {
    final result = await _apiRequests.deleteAddress(id);
    String error = "";
    List<CardModel>? cards;

    result.fold((l) => error = l, (r) {
      final rawCards = r.data["data"]["cards"] as List<dynamic>;

      cards = List<CardModel>.from(rawCards.map((value) => CardModel.fromJson(value)));
    });

    if (cards != null) {
      return Right(cards!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, CardModel>> updateCard(CardModel cardModel) async {
    final result = await _apiRequests.addCard(cardModel.toJson());
    String error = "";
    CardModel? card;

    result.fold((l) => error = l, (r) {
      card = CardModel.fromJson(r.data['data']['card']);
    });

    if (card != null) {
      return Right(card!);
    } else {
      return Left(error);
    }
  }
}
