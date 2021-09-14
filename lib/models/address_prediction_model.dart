class AddressPredictionModel {
  String? description;
  String? placeId;

  AddressPredictionModel({
    this.description,
    this.placeId,
  });

  AddressPredictionModel.fromJson(dynamic json) {
    description = json['description'] as String;
    placeId = json['place_id'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['place_id'] = placeId;
    return map;
  }
}
