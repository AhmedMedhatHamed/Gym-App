import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/home/cubit/home_cubit.dart';
import 'package:gym_app/features/home/widgets/workout_program_card.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutProgramsList extends StatelessWidget {
  const WorkoutProgramsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        if (previous is HomeLoaded && current is HomeLoaded) {
          return previous.filteredPrograms != current.filteredPrograms;
        }
        return true;
      },
      builder: (context, state) {
        return switch (state) {
          HomeLoading() => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          HomeError(:final errorMsg) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    errorMsg,
                    style: AppStyles.noto400Size15,
                  ),
                ),
              ),
            ),
          HomeLoaded(:final filteredPrograms) when filteredPrograms.isEmpty =>
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    'لا توجد برامج في هذا التصنيف',
                    style: AppStyles.noto400Size15,
                  ),
                ),
              ),
            ),
          HomeLoaded(:final filteredPrograms) => SliverList.separated(
              itemCount: filteredPrograms.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                return WorkoutProgramCard(
                  program: filteredPrograms[index],
                );
              },
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
