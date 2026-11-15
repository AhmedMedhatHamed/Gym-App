import 'package:gym_app/core/utils/app_consts.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';

class ExerciseModel {
  final String title;
  final int sets;
  final int reps;
  final int restSeconds;
  final String image;

  const ExerciseModel({
    required this.title,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.image,
  });
}

class WorkoutDetailsModel {
  final String title;
  final int sets;
  final int reps;
  final int calories;
  final String level;
  final String videoPath;
  final List<ExerciseModel> exercises;

  const WorkoutDetailsModel({
    required this.title,
    required this.sets,
    required this.reps,
    required this.calories,
    required this.level,
    required this.videoPath,
    required this.exercises,
  });

  factory WorkoutDetailsModel.fromProgram(WorkoutProgramModel program) {
    return WorkoutDetailsModel(
      title: program.title,
      sets: 3,
      reps: 12,
      calories: program.calories,
      level: program.level,
      videoPath: AppConsts.highDumbbellChestVideo,
      exercises: _exercisesFor(program),
    );
  }
}

List<ExerciseModel> _exercisesFor(WorkoutProgramModel program) {
  if (program.image == AppConsts.dumbbellPress) {
    return const [
      ExerciseModel(
        title: 'ضغط بنج مسطح بالدمبل',
        sets: 3,
        reps: 12,
        restSeconds: 60,
        image: AppConsts.dumbbellPress,
      ),
      ExerciseModel(
        title: 'تفتيح صدر عالي بالدمبل',
        sets: 3,
        reps: 12,
        restSeconds: 60,
        image: AppConsts.bicepFlex,
      ),
      ExerciseModel(
        title: 'متوازي للصدر السفلي',
        sets: 3,
        reps: 12,
        restSeconds: 60,
        image: AppConsts.cutting,
      ),
    ];
  }

  return [
    ExerciseModel(
      title: program.title,
      sets: 3,
      reps: 12,
      restSeconds: 60,
      image: program.image,
    ),
    ExerciseModel(
      title: 'تمرين تكميلي',
      sets: 3,
      reps: 12,
      restSeconds: 60,
      image: AppConsts.latPulldown,
    ),
    ExerciseModel(
      title: 'تمرين ختامي',
      sets: 3,
      reps: 10,
      restSeconds: 60,
      image: AppConsts.cardioRun,
    ),
  ];
}

/// Demo workout matching the details screen design.
const WorkoutDetailsModel chestDumbbellWorkout = WorkoutDetailsModel(
  title: 'تمرين الصدر بالدمبل',
  sets: 3,
  reps: 12,
  calories: 320,
  level: 'مستوى متقدم',
  videoPath: AppConsts.highDumbbellChestVideo,
  exercises: [
    ExerciseModel(
      title: 'ضغط بنج مسطح بالدمبل',
      sets: 3,
      reps: 12,
      restSeconds: 60,
      image: AppConsts.dumbbellPress,
    ),
    ExerciseModel(
      title: 'تفتيح صدر عالي بالدمبل',
      sets: 3,
      reps: 12,
      restSeconds: 60,
      image: AppConsts.bicepFlex,
    ),
    ExerciseModel(
      title: 'متوازي للصدر السفلي',
      sets: 3,
      reps: 12,
      restSeconds: 60,
      image: AppConsts.cutting,
    ),
  ],
);
