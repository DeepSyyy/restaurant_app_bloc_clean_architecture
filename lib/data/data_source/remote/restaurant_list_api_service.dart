import 'package:dio/dio.dart';
import 'package:rest_app_bloc_sm/core/constant.dart';
import 'package:rest_app_bloc_sm/data/models/detail_restaurant_model.dart';
import 'package:rest_app_bloc_sm/data/models/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
part 'restaurant_list_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestaurantApiService {
  factory RestaurantApiService(Dio dio) = _RestaurantApiService;

  @GET("/list")
  Future<HttpResponse<List<RestaurantsModel>>> getRestaurants();

  @GET("/search")
  Future<HttpResponse<List<RestaurantsModel>>> searchRestaurants(
      @Query("q") String query);

  @GET("/detail/{id}")
  Future<HttpResponse<RestaurantModel>> getRestaurant(@Path("id") String id);

  @POST("/review")
  Future<HttpResponse<CustomerReviewModel>> addReview(
      @Body() Map<String, dynamic> body);
}
