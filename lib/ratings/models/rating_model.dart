import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

// Definição da classe Rating com anotações para serialização JSON
@JsonSerializable(explicitToJson: true)
class Rating {

  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  // Métodos para serialização e desserialização JSON
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

}