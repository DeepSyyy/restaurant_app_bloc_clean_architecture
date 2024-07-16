import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/core/usecases/usecase.dart';
import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';

class GetRestaurantUseCase
    implements UseCase<DataState<RestaurantEntity>, String> {
  final RestaurantRepository _restaurantRepository;

  GetRestaurantUseCase(this._restaurantRepository);
  @override
  Future<DataState<RestaurantEntity>> call({String? params}) async {
    return await _restaurantRepository.getRestaurant(params ?? "");
  }
}
