import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';

class RestaurantsModel extends RestaurantsEntity {
  const RestaurantsModel({
    super.id,
    super.name,
    super.description,
    super.pictureId,
    super.city,
    super.rating,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantsModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      pictureId: json['pictureId'] ?? "",
      city: json['city'] ?? "",
      rating: json['rating'].toDouble(),
    );
  }

  factory RestaurantsModel.fromEntity(RestaurantsEntity entity) {
    return RestaurantsModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      pictureId: entity.pictureId,
      city: entity.city,
      rating: entity.rating,
    );
  }
}
