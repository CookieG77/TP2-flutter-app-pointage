import 'package:flutter/cupertino.dart';

class Pointage {
  final String id = UniqueKey().toString();
  final String userId;
  final DateTime dateTime;

  Pointage({
    required this.userId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Pointage.fromMap(Map<String, dynamic> map) {
    return Pointage(
      userId: map['userId'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}