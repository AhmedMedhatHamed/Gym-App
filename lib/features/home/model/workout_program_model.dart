import 'package:gym_app/core/utils/app_consts.dart';

class WorkoutProgramModel {
  final String title;
  final int exercisesCount;
  final int durationMinutes;
  final String level;
  final int calories;
  final String category;
  final String image;

  const WorkoutProgramModel({
    required this.title,
    required this.exercisesCount,
    required this.durationMinutes,
    required this.level,
    required this.calories,
    required this.category,
    required this.image,
  });
}

const List<String> workoutCategories = [
  'جديد',
  'كارديو',
  'لياقة',
  'تنشيف',
];

const List<WorkoutProgramModel> workoutPrograms = [
  WorkoutProgramModel(
    title: 'تمرين الصدر و تراي',
    exercisesCount: 4,
    durationMinutes: 45,
    level: 'مستوى متقدم',
    calories: 320,
    category: 'جديد',
    image: AppConsts.dumbbellPress,
  ),
  WorkoutProgramModel(
    title: 'تمرين الظهر والباي',
    exercisesCount: 5,
    durationMinutes: 50,
    level: 'مستوى متوسط',
    calories: 410,
    category: 'جديد',
    image: AppConsts.latPulldown,
  ),
  WorkoutProgramModel(
    title: 'تمرين كارديو سريع',
    exercisesCount: 6,
    durationMinutes: 30,
    level: 'مستوى مبتدئ',
    calories: 280,
    category: 'كارديو',
    image: AppConsts.cardioRun,
  ),
  WorkoutProgramModel(
    title: 'تمرين لياقة شاملة',
    exercisesCount: 8,
    durationMinutes: 40,
    level: 'مستوى متوسط',
    calories: 350,
    category: 'لياقة',
    image: AppConsts.bicepFlex,
  ),
  WorkoutProgramModel(
    title: 'تمرين تنشيف كامل',
    exercisesCount: 7,
    durationMinutes: 50,
    level: 'مستوى متقدم',
    calories: 420,
    category: 'تنشيف',
    image: AppConsts.cutting,
  ),
];
