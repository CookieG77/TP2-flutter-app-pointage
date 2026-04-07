import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pointage.dart';
import 'auth_service.dart';
import '../models/user.dart';

class PointageService {
  static const String _storageKey = 'pointages';

  static Future<void> addPointage(Pointage pointage) async {
    final prefs = await SharedPreferences.getInstance();
    final pointages = await getPointages();

    pointages.add(pointage);

    final jsonList = pointages
        .map((p) => p.toMap())
        .toList();

    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  static Future<List<Pointage>> getPointages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map((item) => Pointage.fromMap(item))
        .toList();
  }

  static Future<void> clearPointages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  static bool pointageExistsForTodayInGivenList(List<Pointage> pointages) {
    final today = DateTime.now();
    return pointages.any((p) =>
        p.dateTime.year == today.year &&
        p.dateTime.month == today.month &&
        p.dateTime.day == today.day);
  }

  static Future<bool> pointageExistsForToday() async {
    final pointages = await getPointages();
    return pointageExistsForTodayInGivenList(pointages);
  }

  static Future<void> createPointageForToday() async {
    if (await pointageExistsForToday()) {
      return;
    }
    User? user = AuthService.currentUser;
    if (user == null) {
      return;
    }
    final newPointage = Pointage(userId: user.username, dateTime: DateTime.now());
    await addPointage(newPointage);
  }
}