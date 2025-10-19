// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) =>
    Product(
        id: (json['id_'] as num?)?.toInt(),
        externalId: (json['id'] as num?)?.toInt(),
        title: json['title'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        description: json['description'] as String?,
        category: json['category'] as String?,
        image: json['image'] as String?,
      )
      ..rating = json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id_': instance.id,
  'id': instance.externalId,
  'title': instance.title,
  'price': instance.price,
  'description': instance.description,
  'category': instance.category,
  'image': instance.image,
  'rating': instance.rating?.toJson(),
};
