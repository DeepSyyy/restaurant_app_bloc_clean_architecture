import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/domain/usecases/search_restaurants.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_event.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_state.dart';

class RemoteSearchRestaurantBloc
    extends Bloc<RemoteSearchRestaurantEvent, RemoteSearchRestaurantState> {
  final SearcRestaurantsUseCase _searcRestaurants;

  RemoteSearchRestaurantBloc(this._searcRestaurants)
      : super(const RemoteSearchRestaurantLoading()) {
    on<RemoteSearchRestaurant>(onSearchRestaurants);
  }

  void onSearchRestaurants(RemoteSearchRestaurant event,
      Emitter<RemoteSearchRestaurantState> emit) async {
    emit(const RemoteSearchRestaurantLoading());
    final result = await _searcRestaurants(params: event.query);
    if (result is DataSuccess && result.data!.isNotEmpty) {
      emit(RemoteSearchRestaurantDone(restaurants: result.data!));
    }

    if (result is DataSuccess && result.data!.isEmpty) {
      emit(const RemoteSearchRestaurantEmpty());
    }

    if (result is DataFailed) {
      emit(RemoteSearchRestaurantError(exception: result.error!));
    }
  }
}
