import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/domain/usecases/get_restaurant.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_event.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_state.dart';

class RemoteDetailRestaurantBloc
    extends Bloc<RemoteDetailRestaurantEvent, RemoteDetailRestaurantState> {
  final GetRestaurantUseCase _getRestaurantUseCase;

  RemoteDetailRestaurantBloc(this._getRestaurantUseCase)
      : super(const RemoteDetailRestaurantLoading()) {
    on<RemoteDetailRestaurantFetch>(onGetRestaurant);
  }

  void onGetRestaurant(RemoteDetailRestaurantFetch event,
      Emitter<RemoteDetailRestaurantState> emit) async {
    emit(const RemoteDetailRestaurantLoading());
    final result = await _getRestaurantUseCase(params: event.id);
    if (result is DataSuccess) {
      emit(RemoteDetailRestaurantDone(restaurant: result.data!));
    }

    if (result is DataFailed) {
      emit(RemoteDetailRestaurantError(exception: result.error!));
    }
  }
}
