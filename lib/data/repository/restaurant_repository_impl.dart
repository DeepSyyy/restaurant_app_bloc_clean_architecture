import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/data/data_source/remote/restaurant_list_api_service.dart';
import 'package:rest_app_bloc_sm/data/models/restaurant_model.dart';
import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';
import 'package:rest_app_bloc_sm/domain/entities/review_body.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantApiService _restaurantApiService;

  RestaurantRepositoryImpl(this._restaurantApiService);

  @override
  Future<DataState<List<RestaurantsModel>>> getRestaurants() async {
    try {
      final httpResponse = await _restaurantApiService.getRestaurants();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<RestaurantsModel>>> searchRestaurants(
      String query) async {
    try {
      final httpResponse = await _restaurantApiService.searchRestaurants(query);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<RestaurantEntity>> getRestaurant(String id) async {
    try {
      final httpResponse = await _restaurantApiService.getRestaurant(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> postReview(ReviewBody review) async {
    try {
      final httpResponse =
          await _restaurantApiService.addReview(review.toJson());
      if (httpResponse.response.statusCode == HttpStatus.accepted) {
        // ignore: void_checks
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
