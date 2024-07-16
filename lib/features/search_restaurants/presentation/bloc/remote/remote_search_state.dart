import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';

abstract class RemoteSearchRestaurantState extends Equatable {
  final List<RestaurantsEntity>? restaurants;
  final DioException? exception;

  const RemoteSearchRestaurantState({this.restaurants, this.exception});

  @override
  List<Object?> get props => [restaurants!, exception!];
}

class RemoteSearchRestaurantLoading extends RemoteSearchRestaurantState {
  const RemoteSearchRestaurantLoading();
}

class RemoteSearchRestaurantDone extends RemoteSearchRestaurantState {
  const RemoteSearchRestaurantDone(
      {required List<RestaurantsEntity> restaurants})
      : super(restaurants: restaurants);
}

class RemoteSearchRestaurantError extends RemoteSearchRestaurantState {
  const RemoteSearchRestaurantError({required DioException exception})
      : super(exception: exception);
}

class RemoteSearchRestaurantEmpty extends RemoteSearchRestaurantState {
  const RemoteSearchRestaurantEmpty();
}
