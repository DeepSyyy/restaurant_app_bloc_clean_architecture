import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/core/usecases/usecase.dart';
import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';

class GetRestaurantsUseCase
    implements UseCase<DataState<List<RestaurantsEntity>>, void> {
  final RestaurantRepository _restaurantRepository;

  GetRestaurantsUseCase(this._restaurantRepository);
  @override
  Future<DataState<List<RestaurantsEntity>>> call({void params}) {
    return _restaurantRepository.getRestaurants();
  }
}
