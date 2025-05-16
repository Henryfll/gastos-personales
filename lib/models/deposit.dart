class Deposit {
  final String id;
  final double valor;
  final DateTime fecha;
  final String goalId;

  Deposit({
    required this.id,
    required this.valor,
    required this.fecha,
    required this.goalId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'fecha': fecha.toIso8601String(),
      'goalId': goalId,
    };
  }

  factory Deposit.fromMap(String id, Map<String, dynamic> map) {
    return Deposit(
      id: id,
      valor: (map['valor'] ?? 0).toDouble(),
      fecha: DateTime.parse(map['fecha']),
      goalId: map['goalId'] ?? '',
    );
  }
}
