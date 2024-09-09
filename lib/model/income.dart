 


class Income {
  final double amount;
  final String source;
  final String description;
  final DateTime date;

  Income({
    required this.amount,
    required this.source,
    required this.description,
    required this.date,
  });

  // Convert an Income object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'source': source,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Convert a Map to an Income object
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      amount: json['amount'],
      source: json['source'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}

