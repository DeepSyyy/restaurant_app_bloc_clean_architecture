import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';

abstract class RemoteDetailRestaurantState extends Equatable {
  final RestaurantEntity? restaurant;
  final DioException? exception;
  const RemoteDetailRestaurantState({this.restaurant, this.exception});

  @override
  List<Object?> get props => [restaurant!, exception!];
}

class RemoteDetailRestaurantLoading extends RemoteDetailRestaurantState {
  const RemoteDetailRestaurantLoading();
}

class RemoteDetailRestaurantDone extends RemoteDetailRestaurantState {
  const RemoteDetailRestaurantDone({required RestaurantEntity restaurant})
      : super(restaurant: restaurant);
}

class RemoteDetailRestaurantError extends RemoteDetailRestaurantState {
  const RemoteDetailRestaurantError({required DioException exception})
      : super(exception: exception);
}
