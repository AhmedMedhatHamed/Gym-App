import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:gym_app/features/home/cubit/home_cubit.dart';
import 'package:gym_app/features/home/widgets/daily_activity_section.dart';
import 'package:gym_app/features/home/widgets/home_categories_section.dart';
import 'package:gym_app/features/home/widgets/home_header.dart';
import 'package:gym_app/features/home/widgets/home_search_field.dart';
import 'package:gym_app/features/home/widgets/section_header.dart';
import 'package:gym_app/features/home/widgets/workout_programs_list.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const int currentNavIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                  const SliverToBoxAdapter(child: HomeHeader()),
                  const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
                  SliverToBoxAdapter(
                    child: HomeSearchField(
                      onChanged: (query) {
                        context.read<HomeCubit>().searchWorkouts(query);
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                  const SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'نشاطك اليومي',
                      actionText: 'عرض الكل',
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14.0)),
                  const SliverToBoxAdapter(child: DailyActivitySection()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                  const SliverToBoxAdapter(
                    child: SectionHeader(title: 'البرامج التدريبية'),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14.0)),
                  const SliverToBoxAdapter(child: HomeCategoriesSection()),
                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                  const WorkoutProgramsList(),
                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
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
                  currentIndex: currentNavIndex,
                  targetIndex: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
