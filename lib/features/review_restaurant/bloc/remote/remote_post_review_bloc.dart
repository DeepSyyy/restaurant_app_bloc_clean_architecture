import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_app_bloc_sm/core/resources/data_state.dart';
import 'package:rest_app_bloc_sm/domain/usecases/post_review.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_event.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_state.dart';

class RemotePostReviewBloc
    extends Bloc<RemotePostReviewEvent, RemotePostReviewState> {
  final PostReviewUseCase _postReviewUseCase;

  RemotePostReviewBloc(this._postReviewUseCase)
      : super(const RemotePostReviewLoading()) {
    on<RemotePostReview>(onPostReview);
  }

  void onPostReview(
      RemotePostReview event, Emitter<RemotePostReviewState> emit) async {
    emit(const RemotePostReviewLoading());
    final result = await _postReviewUseCase(params: event.toReviewBody());
    if (result is DataSuccess) {
      emit(RemotePostReviewtDone(restaurant: result.data!));
    }
    if (result is DataFailed) {
      emit(RemotePostReviewError(exception: result.error!));
    }
  }
}
