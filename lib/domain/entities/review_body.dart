class ReviewBody {
  final String id;
  final String name;
  final String review;

  ReviewBody(this.id, this.name, this.review);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
    };
  }
}
