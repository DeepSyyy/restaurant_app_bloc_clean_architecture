import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/core/usecases/usecase.dart';
import 'package:rest_app_bloc_sm/domain/entities/review_body.dart';
import 'package:rest_app_bloc_sm/domain/repository/restaurant_repository.dart';

class PostReviewUseCase implements UseCase<DataState<void>, ReviewBody> {
  final RestaurantRepository _reviewRepository;

  PostReviewUseCase(this._reviewRepository);

  @override
  Future<DataState<void>> call({ReviewBody? params}) async {
    return await _reviewRepository.postReview(params ?? ReviewBody("", "", ""));
  }
}
