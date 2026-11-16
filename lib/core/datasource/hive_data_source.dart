import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource {
  static const String profileBoxName = 'profile_box';
  static const String profileImageKey = 'profile_image';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(profileBoxName);
  }

  static Box get _profileBox => Hive.box(profileBoxName);

  static String get _activeKey {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return uid != null ? '${profileImageKey}_$uid' : profileImageKey;
  }

  static Future<void> saveProfileImage(Uint8List imageBytes) async {
    final key = _activeKey;
    await _profileBox.put(key, imageBytes);
    await _profileBox.put(profileImageKey, imageBytes);
  }

  static Uint8List? getProfileImage() {
    if (!Hive.isBoxOpen(profileBoxName)) return null;

    dynamic data = _profileBox.get(_activeKey);
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
    await _profileBox.delete(_activeKey);
    await _profileBox.delete(profileImageKey);
  }
}
