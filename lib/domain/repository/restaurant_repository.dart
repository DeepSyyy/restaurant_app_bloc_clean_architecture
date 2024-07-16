import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/data/models/restaurant_model.dart';
import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';
import 'package:rest_app_bloc_sm/domain/entities/review_body.dart';

abstract class RestaurantRepository {
  //API methods
  Future<DataState<List<RestaurantsModel>>> getRestaurants();
  Future<DataState<List<RestaurantsModel>>> searchRestaurants(String query);
  Future<DataState<RestaurantEntity>> getRestaurant(String id);
  Future<DataState<void>> postReview(ReviewBody review);
}
