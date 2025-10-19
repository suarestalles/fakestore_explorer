import 'package:fakestore_explorer/ratings/models/rating_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'product_model.g.dart';

// Definição da classe Product com anotações para serialização JSON e mapeamento ObjectBox
@JsonSerializable(explicitToJson: true)
@Entity()
class Product {
  @JsonKey(name: 'id_')
  int? id;
  @JsonKey(name: 'id')
  int? externalId;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  @Transient()
  Rating? rating;

  // Construtor da classe Product
  Product({
    this.id,
    this.externalId,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  // Métodos para serialização e desserialização JSON
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}