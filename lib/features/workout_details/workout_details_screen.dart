import 'dart:async';

import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/workout_details/model/workout_details_model.dart';
import 'package:gym_app/features/workout_details/widgets/exercise_list_item.dart';
import 'package:gym_app/features/workout_details/widgets/workout_details_app_bar.dart';
import 'package:gym_app/features/workout_details/widgets/workout_info_section.dart';
import 'package:gym_app/features/workout_details/widgets/workout_video_preview.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  const WorkoutDetailsScreen({
    super.key,
    this.workout = chestDumbbellWorkout,
  });

  final WorkoutDetailsModel workout;

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  static const int currentNavIndex = 2;
  final GlobalKey<WorkoutVideoPreviewState> _videoKey =
      GlobalKey<WorkoutVideoPreviewState>();
  int? selectedExerciseIndex;
  int? pausedExerciseIndex;
  int remainingSeconds = 0;
  Timer? _restTimer;

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }

  void _onPlayPausePressed(int index) {
    final exercise = widget.workout.exercises[index];

    // Already resting on this exercise → cancel rest and return to play.
    if (pausedExerciseIndex == index) {
      _stopRestTimer();
      _videoKey.currentState?.playVideo();
      setState(() {
        pausedExerciseIndex = null;
        remainingSeconds = 0;
        selectedExerciseIndex = index;
      });
      return;
    }

    // Selected / playing → press pause starts a 60sec rest timer.
    if (selectedExerciseIndex == index && pausedExerciseIndex == null) {
      _videoKey.currentState?.pauseVideo();
      _startRestTimer(index, exercise.restSeconds);
      return;
    }

    // Select a new exercise (show pause icon when active).
    _stopRestTimer();
    _videoKey.currentState?.playVideo();
    setState(() {
      selectedExerciseIndex = index;
      pausedExerciseIndex = null;
      remainingSeconds = 0;
    });
  }

  void _startRestTimer(int index, int seconds) {
    _restTimer?.cancel();
    setState(() {
      pausedExerciseIndex = index;
      remainingSeconds = seconds;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 1) {
        timer.cancel();
        _videoKey.currentState?.playVideo();
        setState(() {
          pausedExerciseIndex = null;
          remainingSeconds = 0;
          selectedExerciseIndex = index;
        });
        return;
      }

      setState(() {
        remainingSeconds -= 1;
      });
    });
  }

  void _stopRestTimer() {
    _restTimer?.cancel();
    _restTimer = null;
  }

  String _getButtonText(int totalExercises) {
    final int? activeIndex = selectedExerciseIndex ?? pausedExerciseIndex;
    if (activeIndex == null || totalExercises == 0) {
      return 'ابدأ التمرين الآن';
    }
    if (activeIndex < totalExercises - 1) {
      return 'التمرين التالي (${activeIndex + 2}/$totalExercises)';
    }
    return 'إنهاء التمرين';
  }

  void _onMainActionPressed() {
    final exercises = widget.workout.exercises;
    if (exercises.isEmpty) return;

    final int? activeIndex = selectedExerciseIndex ?? pausedExerciseIndex;
    if (activeIndex == null || activeIndex < exercises.length - 1) {
      final int nextIndex = activeIndex == null ? 0 : activeIndex + 1;
      _stopRestTimer();
      _videoKey.currentState?.playVideo();
      setState(() {
        selectedExerciseIndex = nextIndex;
        pausedExerciseIndex = null;
        remainingSeconds = 0;
      });
      return;
    }

    _stopRestTimer();
    _videoKey.currentState?.pauseVideo();
    setState(() {
      selectedExerciseIndex = null;
      pausedExerciseIndex = null;
      remainingSeconds = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(color: AppColors.primaryColor, width: 1.0),
        ),
        content: Text(
          'عاش يا بطل! أتممت ${widget.workout.title} وحرقت ${widget.workout.calories} سعرة حرارية 🔥',
          textDirection: TextDirection.rtl,
          style: AppStyles.noto700Size16.copyWith(
            fontSize: 13.0,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workout = widget.workout;
    final coverImage = workout.exercises.first.image;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                const WorkoutDetailsAppBar(),
                const SizedBox(height: 20.0),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: WorkoutVideoPreview(
                          key: _videoKey,
                          videoPath: workout.videoPath,
                          imagePath: coverImage,
                          onPlayPressed: () {
                            if (selectedExerciseIndex == null &&
                                pausedExerciseIndex == null &&
                                workout.exercises.isNotEmpty) {
                              _onPlayPausePressed(0);
                            }
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
                      SliverToBoxAdapter(
                        child: WorkoutInfoSection(workout: workout),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                      SliverToBoxAdapter(
                        child: Text(
                          'جدول التمارين (${workout.exercises.length})',
                          style: AppStyles.noto700Size16.copyWith(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 14.0)),
                      SliverList.separated(
                        itemCount: workout.exercises.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 12.0),
                        itemBuilder: (context, index) {
                          final exercise = workout.exercises[index];
                          final isSelected = selectedExerciseIndex == index;
                          final isPaused = pausedExerciseIndex == index;

                          return ExerciseListItem(
                            exercise: exercise,
                            isSelected: isSelected || isPaused,
                            isPaused: isPaused,
                            remainingSeconds: isPaused ? remainingSeconds : 0,
                            onPlayPausePressed: () =>
                                _onPlayPausePressed(index),
                          );
                        },
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                    ],
                  ),
                ),
                CustomButton(
                  text: _getButtonText(workout.exercises.length),
                  onPressed: _onMainActionPressed,
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
          child: CustomBottomNavBar(
            currentIndex: currentNavIndex,
            onTap: (index) {
              AppRouter.navigateByNavIndex(
                context,
                currentIndex: -1,
                targetIndex: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
