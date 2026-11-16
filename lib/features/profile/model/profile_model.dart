import 'dart:typed_data';

import 'package:flutter/material.dart';

final ValueNotifier<Uint8List?> profileImageNotifier =
    ValueNotifier<Uint8List?>(null);

final ValueNotifier<String> userNameNotifier = ValueNotifier<String>('');

final ValueNotifier<List<ProfileWorkoutLogModel>> workoutLogsNotifier =
    ValueNotifier<List<ProfileWorkoutLogModel>>([]);

final ValueNotifier<int> burnedCaloriesNotifier = ValueNotifier<int>(0);

final ValueNotifier<int> workoutMinutesNotifier = ValueNotifier<int>(0);

final ValueNotifier<int> todayStepsNotifier = ValueNotifier<int>(0);

class ProfileBadgeModel {
  final String title;
  final String emoji;
  final Color bgColor;

  const ProfileBadgeModel({
    required this.title,
    required this.emoji,
    required this.bgColor,
  });
}

class ProfileWorkoutLogModel {
  final String title;
  final String subtitle;
  final String emoji;
  final Color boxColor;

  const ProfileWorkoutLogModel({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.boxColor,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'emoji': emoji,
      'boxColor': boxColor.toARGB32(),
    };
  }

  factory ProfileWorkoutLogModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileWorkoutLogModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '💪',
      boxColor: Color((json['boxColor'] as num?)?.toInt() ?? 0xff2A2F1B),
    );
  }
}

const List<ProfileBadgeModel> profileBadges = [
  ProfileBadgeModel(
    title: 'حارق الدهون',
    emoji: '🔥',
    bgColor: Color(0xff2B2118),
  ),
  ProfileBadgeModel(
    title: 'الالتزام 30 يوم',
    emoji: '⚡',
    bgColor: Color(0xff1A272D),
  ),
  ProfileBadgeModel(
    title: 'بطل الأسبوع',
    emoji: '🏆',
    bgColor: Color(0xff292418),
  ),
];

const List<ProfileWorkoutLogModel> profileWorkoutLogs = [];
