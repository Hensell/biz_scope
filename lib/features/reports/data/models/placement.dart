class Placement {
  final String officer;
  final DateTime date;
  final double amount;
  final String client;
  final String product;
  final String branch;

  Placement({
    required this.officer,
    required this.date,
    required this.amount,
    required this.client,
    required this.product,
    required this.branch,
  });

  factory Placement.fromJson(Map<String, dynamic> json) => Placement(
    officer: json['officer'] as String,
    date: DateTime.parse(json['date'] as String),
    amount: (json['amount'] as num).toDouble(),
    client: json['client'] as String,
    product: json['product'] as String,
    branch: json['branch'] as String,
  );

  Map<String, dynamic> toJson() => {
    'officer': officer,
    'date': date.toIso8601String(),
    'amount': amount,
    'client': client,
    'product': product,
    'branch': branch,
  };
}
