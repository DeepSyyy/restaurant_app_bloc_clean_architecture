import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/core/usecases/usecase.dart';
import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';

class SearcRestaurantsUseCase
    implements UseCase<DataState<List<RestaurantsEntity>>, String> {
  final RestaurantRepository _restaurantRepository;

  SearcRestaurantsUseCase(this._restaurantRepository);

  @override
  Future<DataState<List<RestaurantsEntity>>> call({String? params}) async {
    return await _restaurantRepository.searchRestaurants(params ?? "");
  }
}
