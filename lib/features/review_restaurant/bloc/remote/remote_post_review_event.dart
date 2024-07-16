import 'package:rest_app_bloc_sm/domain/entities/review_body.dart';

abstract class RemotePostReviewEvent {
  const RemotePostReviewEvent();
}

class RemotePostReview extends RemotePostReviewEvent {
  final String id;
  final String review;
  final String name;
  const RemotePostReview({
    required this.id,
    required this.review,
    required this.name,
  });

  ReviewBody toReviewBody() {
    return ReviewBody(id, name, review);
  }
}
