class Expense {
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  Expense({
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  // Convert an Expense object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Convert a Map to an Expense object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'],
      category: json['category'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
