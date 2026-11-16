import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gym_app/core/datasource/hive_data_source.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepTrackingService {
  StepTrackingService._();
  static final StepTrackingService instance = StepTrackingService._();

  StreamSubscription<StepCount>? _stepCountSubscription;
  bool _isInitialized = false;

  Future<void> init() async {
    todayStepsNotifier.value = HiveDataSource.getTodaySteps();

    if (_isInitialized) return;
    _isInitialized = true;

    await requestPermissionAndStart();
  }

  Future<bool> requestPermissionAndStart() async {
    try {
      final status = await Permission.activityRecognition.request();
      if (status.isGranted) {
        _startListening();
        return true;
      }
    } catch (e) {
      debugPrint('Error requesting activity recognition permission: $e');
    }
    return false;
  }

  void _startListening() {
    _stepCountSubscription?.cancel();
    _stepCountSubscription = Pedometer.stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
      cancelOnError: false,
    );
  }

  Future<void> _onStepCount(StepCount event) async {
    final now = DateTime.now();
    final todayDate = '${now.year}-${now.month}-${now.day}';
    final savedDate = HiveDataSource.getStepDate();
    int? base = HiveDataSource.getStepBase();

    if (savedDate != todayDate || base == null || event.steps < base) {
      base = event.steps;
      await HiveDataSource.saveStepDate(todayDate);
      await HiveDataSource.saveStepBase(base);
      await HiveDataSource.saveTodaySteps(0);
      todayStepsNotifier.value = 0;
    } else {
      final currentTodaySteps = event.steps - base;
      await HiveDataSource.saveTodaySteps(currentTodaySteps);
      todayStepsNotifier.value = currentTodaySteps;
    }
  }

  void _onStepCountError(dynamic error) {
    debugPrint('Pedometer error: $error');
  }

  void stop() {
    _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    _isInitialized = false;
  }
}
