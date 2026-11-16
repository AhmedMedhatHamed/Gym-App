import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource {
  static const String profileBoxName = 'profile_box';
  static const String profileImageKey = 'profile_image';
  static const String userNameKey = 'user_name';

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
}
