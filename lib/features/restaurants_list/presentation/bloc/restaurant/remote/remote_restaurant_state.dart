import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';

abstract class RemoteRestaurantState extends Equatable {
  final List<RestaurantsEntity>? restaurants;
  final DioException? exception;
  const RemoteRestaurantState({this.restaurants, this.exception});

  @override
  List<Object?> get props => [restaurants!, exception!];
}

class RemoteRestaurantLoading extends RemoteRestaurantState {
  const RemoteRestaurantLoading();
}

class RemoteRestaurantDone extends RemoteRestaurantState {
  const RemoteRestaurantDone({required List<RestaurantsEntity> restaurants})
      : super(restaurants: restaurants);
}

class RemoteRestaurantError extends RemoteRestaurantState {
  const RemoteRestaurantError({required DioException exception})
      : super(exception: exception);
}
