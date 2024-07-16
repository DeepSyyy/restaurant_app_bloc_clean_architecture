import 'package:equatable/equatable.dart';

class RestaurantsEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  const RestaurantsEntity({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  @override
  List<Object?> get props => [id, name, description, pictureId, city, rating];
}
