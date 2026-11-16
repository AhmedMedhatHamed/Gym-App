import 'dart:typed_data';

import 'package:flutter/material.dart';

final ValueNotifier<Uint8List?> profileImageNotifier =
    ValueNotifier<Uint8List?>(null);

final ValueNotifier<String> userNameNotifier = ValueNotifier<String>('');

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

const List<ProfileWorkoutLogModel> profileWorkoutLogs = [
  ProfileWorkoutLogModel(
    title: 'تمرين الصدر والبنج',
    subtitle: 'أمس، 45 دقيقة • 320 سعرة',
    emoji: '💪',
    boxColor: Color(0xff2A2F1B),
  ),
  ProfileWorkoutLogModel(
    title: 'كارديو وحرق دهون',
    subtitle: 'منذ يومين، 30 دقيقة • 280 سعرة',
    emoji: '🏃',
    boxColor: Color(0xff182830),
  ),
];
