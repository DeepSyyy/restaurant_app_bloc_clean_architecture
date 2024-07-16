import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<CategoryEntity>? categories;
  final MenusEntity? menus;
  final double? rating;
  final List<CustomerReviewEntity>? customerReviews;

  const RestaurantEntity({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        categories,
        menus,
        rating,
        customerReviews,
      ];
}

class CategoryEntity extends Equatable {
  final String? name;

  const CategoryEntity({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}

class CustomerReviewEntity extends Equatable {
  final String? name;
  final String? review;
  final String? date;

  const CustomerReviewEntity({
    this.name,
    this.review,
    this.date,
  });

  @override
  List<Object?> get props => [name, review, date];
}

class MenusEntity extends Equatable {
  final List<CategoryEntity>? foods;
  final List<CategoryEntity>? drinks;

  const MenusEntity({
    this.foods,
    this.drinks,
  });

  @override
  List<Object?> get props => [foods, drinks];
}
