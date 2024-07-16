import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_app_bloc_sm/data/data_source/remote/restaurant_list_api_service.dart';
import 'package:rest_app_bloc_sm/data/repository/restaurant_repository_impl.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';
import 'package:rest_app_bloc_sm/domain/usecases/get_restaurant.dart';
import 'package:rest_app_bloc_sm/domain/usecases/get_restaurants.dart';
import 'package:rest_app_bloc_sm/domain/usecases/post_review.dart';
import 'package:rest_app_bloc_sm/domain/usecases/search_restaurants.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_bloc.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDepedencies() async {
  //Dio (Init first because it's used in other services)
  sl.registerSingleton<Dio>(Dio());

  //Depedencies
  sl.registerSingleton<RestaurantApiService>(RestaurantApiService(sl()));

  sl.registerSingleton<RestaurantRepository>(RestaurantRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetRestaurantsUseCase>(GetRestaurantsUseCase(sl()));
  sl.registerSingleton<SearcRestaurantsUseCase>(SearcRestaurantsUseCase(sl()));
  sl.registerSingleton<GetRestaurantUseCase>(GetRestaurantUseCase(sl()));
  sl.registerSingleton<PostReviewUseCase>(PostReviewUseCase(sl()));

  //Bloc
  sl.registerFactory<RemoteRestaurantBloc>(() => RemoteRestaurantBloc(sl()));
  sl.registerFactory<RemoteSearchRestaurantBloc>(
      () => RemoteSearchRestaurantBloc(sl()));
  sl.registerFactory<RemoteDetailRestaurantBloc>(
      () => RemoteDetailRestaurantBloc(sl()));
  sl.registerFactory(() => RemotePostReviewBloc(sl()));
}
