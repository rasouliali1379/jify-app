class CardModel {
  String? id;
  String? cardBrand;
  String? cardNumber;
  String? cardHolderName;
  int? expireDateMonth;
  int? expireDateYear;

  CardModel({
    this.id,
    this.cardNumber,
    this.cardBrand,
    this.cardHolderName,
    this.expireDateMonth,
    this.expireDateYear,
  });

  CardModel.fromJson(dynamic json) {
    cardBrand = json['cardBrand'] as String;
    cardNumber = json['cardNumber'] as String;
    cardHolderName = json['cardHolderName'] as String;
    expireDateMonth = json['expireDateMonth'] as int;
    expireDateYear = json['expireDateYear'] as int;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cardNumber'] = cardNumber;
    map['cardHolderName'] = cardHolderName;
    map['expireDateMonth'] = expireDateMonth;
    map['expireDateYear'] = expireDateYear;
    return map;
  }
}
