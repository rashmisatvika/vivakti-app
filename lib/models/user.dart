class AppUser {
  final String id;
  final String phone;
  final String? name;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.phone,
    this.name,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': createdAt.toIso8601String(),
      };
}
