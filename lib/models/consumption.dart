import 'package:flutter/foundation.dart';

class Consumption {
  int? id;
  String? type;
  DateTime? date;
  double? weight;

  Consumption({
    this.id,
    this.type,
    this.date,
    this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date?.toIso8601String(),
      'weight': weight,
    };
  }

  factory Consumption.fromMap(Map<String, dynamic> map) {
    return Consumption(
      id: map['id'] as int?,
      type: map['type'] as String?,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      weight: map['weight'] as double?,
    );
  }
}
