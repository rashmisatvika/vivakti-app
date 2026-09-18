enum TransactionStatus { pending, completed, failed }

class AppTransaction {
  final String id;
  final String userId;
  final String serviceId;
  final int amount;
  final TransactionStatus status;
  final String paymentMethod;
  final DateTime createdAt;

  AppTransaction({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory AppTransaction.fromJson(Map<String, dynamic> json) {
    return AppTransaction(
      id: json['id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      amount: json['amount'],
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
      paymentMethod: json['payment_method'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'service_id': serviceId,
        'amount': amount,
        'status': status.name,
        'payment_method': paymentMethod,
        'created_at': createdAt.toIso8601String(),
      };
}
