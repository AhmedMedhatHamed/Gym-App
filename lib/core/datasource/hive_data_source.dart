import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource {
  static const String profileBoxName = 'profile_box';
  static const String profileImageKey = 'profile_image';
  static const String userNameKey = 'user_name';
  static const String workoutLogsKey = 'workout_logs';
  static const String burnedCaloriesKey = 'burned_calories';
  static const String workoutMinutesKey = 'workout_minutes';
  static const String todayStepsKey = 'today_steps';
  static const String stepBaseKey = 'step_base';
  static const String stepDateKey = 'step_date';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(profileBoxName);
  }

  static Box get _profileBox => Hive.box(profileBoxName);

  static String _activeKeyFor(String key) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return uid != null ? '${key}_$uid' : key;
  }

  static Future<void> saveProfileImage(Uint8List imageBytes) async {
    final key = _activeKeyFor(profileImageKey);
    await _profileBox.put(key, imageBytes);
    await _profileBox.put(profileImageKey, imageBytes);
  }

  static Uint8List? getProfileImage() {
    if (!Hive.isBoxOpen(profileBoxName)) return null;

    dynamic data = _profileBox.get(_activeKeyFor(profileImageKey));
    data ??= _profileBox.get(profileImageKey);

    if (data == null) return null;
    if (data is Uint8List) return data;
    if (data is List) {
      return Uint8List.fromList(List<int>.from(data));
    }
    return null;
  }

  static Future<void> deleteProfileImage() async {
    if (!Hive.isBoxOpen(profileBoxName)) return;
    await _profileBox.delete(_activeKeyFor(profileImageKey));
    await _profileBox.delete(profileImageKey);
  }

  static Future<void> saveUserName(String name) async {
    final key = _activeKeyFor(userNameKey);
    await _profileBox.put(key, name);
    await _profileBox.put(userNameKey, name);
  }

  static String? getUserName() {
    if (!Hive.isBoxOpen(profileBoxName)) return null;

    dynamic name = _profileBox.get(_activeKeyFor(userNameKey));
    name ??= _profileBox.get(userNameKey);
    return name as String?;
  }

  static Future<void> deleteUserName() async {
    if (!Hive.isBoxOpen(profileBoxName)) return;
    await _profileBox.delete(_activeKeyFor(userNameKey));
    await _profileBox.delete(userNameKey);
  }

  static Future<void> addWorkoutLog(ProfileWorkoutLogModel log) async {
    final logs = getWorkoutLogs();
    logs.insert(0, log);
    final rawList = logs.map((item) => item.toJson()).toList();
    final key = _activeKeyFor(workoutLogsKey);
    await _profileBox.put(key, rawList);
    await _profileBox.put(workoutLogsKey, rawList);
  }

  static List<ProfileWorkoutLogModel> getWorkoutLogs() {
    if (!Hive.isBoxOpen(profileBoxName)) return [];
    dynamic data = _profileBox.get(_activeKeyFor(workoutLogsKey));
    data ??= _profileBox.get(workoutLogsKey);
    if (data == null || data is! List) return [];

    return data
        .whereType<Map>()
        .map((m) => ProfileWorkoutLogModel.fromJson(m))
        .toList();
  }

  static Future<void> deleteWorkoutLog(int index) async {
    final logs = getWorkoutLogs();
    if (index >= 0 && index < logs.length) {
      logs.removeAt(index);
      final rawList = logs.map((item) => item.toJson()).toList();
      final key = _activeKeyFor(workoutLogsKey);
      await _profileBox.put(key, rawList);
      await _profileBox.put(workoutLogsKey, rawList);
    }
  }

  static Future<void> addBurnedCalories(int calories) async {
    final current = getBurnedCalories();
    final updated = current + calories;
    final key = _activeKeyFor(burnedCaloriesKey);
    await _profileBox.put(key, updated);
    await _profileBox.put(burnedCaloriesKey, updated);
  }

  static int getBurnedCalories() {
    if (!Hive.isBoxOpen(profileBoxName)) return 0;
    dynamic data = _profileBox.get(_activeKeyFor(burnedCaloriesKey));
    data ??= _profileBox.get(burnedCaloriesKey);
    return (data as num?)?.toInt() ?? 0;
  }

  static Future<void> addWorkoutMinutes(int minutes) async {
    final current = getWorkoutMinutes();
    final updated = current + minutes;
    final key = _activeKeyFor(workoutMinutesKey);
    await _profileBox.put(key, updated);
    await _profileBox.put(workoutMinutesKey, updated);
  }

  static int getWorkoutMinutes() {
    if (!Hive.isBoxOpen(profileBoxName)) return 0;
    dynamic data = _profileBox.get(_activeKeyFor(workoutMinutesKey));
    data ??= _profileBox.get(workoutMinutesKey);
    return (data as num?)?.toInt() ?? 0;
  }

  static int getTodaySteps() {
    if (!Hive.isBoxOpen(profileBoxName)) return 0;
    dynamic data = _profileBox.get(_activeKeyFor(todayStepsKey));
    data ??= _profileBox.get(todayStepsKey);
    return (data as num?)?.toInt() ?? 0;
  }

  static Future<void> saveTodaySteps(int steps) async {
    final key = _activeKeyFor(todayStepsKey);
    await _profileBox.put(key, steps);
    await _profileBox.put(todayStepsKey, steps);
  }

  static String? getStepDate() {
    if (!Hive.isBoxOpen(profileBoxName)) return null;
    dynamic data = _profileBox.get(_activeKeyFor(stepDateKey));
    data ??= _profileBox.get(stepDateKey);
    return data as String?;
  }

  static Future<void> saveStepDate(String date) async {
    final key = _activeKeyFor(stepDateKey);
    await _profileBox.put(key, date);
    await _profileBox.put(stepDateKey, date);
  }

  static int? getStepBase() {
    if (!Hive.isBoxOpen(profileBoxName)) return null;
    dynamic data = _profileBox.get(_activeKeyFor(stepBaseKey));
    data ??= _profileBox.get(stepBaseKey);
    return (data as num?)?.toInt();
  }

  static Future<void> saveStepBase(int base) async {
    final key = _activeKeyFor(stepBaseKey);
    await _profileBox.put(key, base);
    await _profileBox.put(stepBaseKey, base);
  }
}
