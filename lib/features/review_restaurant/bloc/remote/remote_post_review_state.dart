import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rest_app_bloc_sm/domain/entities/detail_restaurant_entity.dart';

abstract class RemotePostReviewState extends Equatable {
  final CustomerReviewEntity? restaurant;
  final DioException? exception;
  const RemotePostReviewState({this.restaurant, this.exception});

  @override
  List<Object?> get props => [restaurant!, exception!];
}

class RemotePostReviewLoading extends RemotePostReviewState {
  const RemotePostReviewLoading();
}

class RemotePostReviewtDone extends RemotePostReviewState {
  const RemotePostReviewtDone({required CustomerReviewEntity restaurant})
      : super(restaurant: restaurant);
}

class RemotePostReviewError extends RemotePostReviewState {
  const RemotePostReviewError({required DioException exception})
      : super(exception: exception);
}
