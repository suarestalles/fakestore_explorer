import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Rating {

  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

}