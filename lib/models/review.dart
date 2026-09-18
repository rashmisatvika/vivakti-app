class Review {
  final String id;
  final int rating;
  final String? comment;
  final String userId;
  final String serviceId;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.rating,
    this.comment,
    required this.userId,
    required this.serviceId,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'comment': comment,
        'user_id': userId,
        'service_id': serviceId,
        'created_at': createdAt.toIso8601String(),
      };
}
