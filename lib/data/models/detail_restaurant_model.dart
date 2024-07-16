import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    super.id,
    super.name,
    super.description,
    super.city,
    super.address,
    super.pictureId,
    super.categories,
    super.menus,
    super.rating,
    super.customerReviews,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      city: json['city'] ?? "",
      address: json['address'] ?? "",
      pictureId: json['pictureId'] ?? "",
      categories: json['categories'] != null
          ? List<CategoryModel>.from(
              json['categories'].map((x) => CategoryModel.fromJson(x)))
          : [],
      menus: MenusModel.fromJson(json['menus']),
      rating: json['rating'].toDouble(),
      customerReviews: json['customerReviews'] != null
          ? List<CustomerReviewModel>.from(json['customerReviews']
              .map((x) => CustomerReviewModel.fromJson(x)))
          : [],
    );
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? "",
    );
  }
}

class MenusModel extends MenusEntity {
  const MenusModel({
    super.foods,
    super.drinks,
  });

  factory MenusModel.fromJson(Map<String, dynamic> json) {
    return MenusModel(
      foods:
          List<FoodModel>.from(json['foods'].map((x) => FoodModel.fromJson(x))),
      drinks: List<DrinkModel>.from(
          json['drinks'].map((x) => DrinkModel.fromJson(x))),
    );
  }
}

class FoodModel extends CategoryModel {
  const FoodModel({
    super.name,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'] ?? "",
    );
  }
}

class DrinkModel extends CategoryModel {
  const DrinkModel({
    super.name,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      name: json['name'] ?? "",
    );
  }
}

class CustomerReviewModel extends CustomerReviewEntity {
  const CustomerReviewModel({
    super.name,
    super.review,
    super.date,
  });

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) {
    return CustomerReviewModel(
      name: json['name'] ?? "",
      review: json['review'] ?? "",
      date: json['date'] ?? "",
    );
  }
}
