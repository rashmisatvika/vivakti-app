class Service {
  final String id;
  final String title;
  final String category;
  final String description;
  final bool isOnline;
  final int price;

  Service({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.isOnline,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      isOnline: json['is_online'] ?? false,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'description': description,
        'is_online': isOnline,
        'price': price,
      };
}
