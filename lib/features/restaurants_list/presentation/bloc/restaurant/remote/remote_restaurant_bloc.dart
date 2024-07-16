import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/domain/usecases/get_restaurants.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_event.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_state.dart';

class RemoteRestaurantBloc
    extends Bloc<RemoteRestaurantEvent, RemoteRestaurantState> {
  final GetRestaurantsUseCase _getRestaurants;
  RemoteRestaurantBloc(this._getRestaurants)
      : super(const RemoteRestaurantLoading()) {
    on<RemoteRestaurantFetch>(onGetRestaurants);
  }

  void onGetRestaurants(
    RemoteRestaurantFetch event,
    Emitter<RemoteRestaurantState> emit,
  ) async {
    emit(const RemoteRestaurantLoading());
    final result = await _getRestaurants();
    if (result is DataSuccess && result.data!.isNotEmpty) {
      emit(RemoteRestaurantDone(restaurants: result.data!));
    }

    if (result is DataFailed) {
      emit(RemoteRestaurantError(exception: result.error!));
    }
  }
}
