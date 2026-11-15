import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';
import 'package:gym_app/features/home/widgets/activity_progress_card.dart';
import 'package:gym_app/features/home/widgets/category_chips.dart';
import 'package:gym_app/features/home/widgets/home_header.dart';
import 'package:gym_app/features/home/widgets/home_search_field.dart';
import 'package:gym_app/features/home/widgets/section_header.dart';
import 'package:gym_app/features/home/widgets/workout_program_card.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentNavIndex = 2;
  String selectedCategory = workoutCategories.first;

  @override
  Widget build(BuildContext context) {
    final filteredPrograms = workoutPrograms
        .where((program) => program.category == selectedCategory)
        .toList();

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
                  const SliverToBoxAdapter(child: HomeSearchField()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                  const SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'نشاطك اليومي',
                      actionText: 'عرض الكل',
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14.0)),
                  const SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: ActivityProgressCard(
                            value: '640',
                            progress: 0.78,
                            progressColor: AppColors.primaryColor,
                            title: 'السعرات المحروقة',
                            subtitle: 'سعرة حرارية',
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: ActivityProgressCard(
                            value: '8,420',
                            progress: 0.842,
                            progressColor: AppColors.cyanColor,
                            title: 'عدد الخطوات',
                            subtitle: 'الهدف: 10,000',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                  const SliverToBoxAdapter(
                    child: SectionHeader(title: 'البرامج التدريبية'),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14.0)),
                  SliverToBoxAdapter(
                    child: CategoryChips(
                      categories: workoutCategories,
                      selectedCategory: selectedCategory,
                      onSelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                  if (filteredPrograms.isEmpty)
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
                    )
                  else
                    SliverList.separated(
                      itemCount: filteredPrograms.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 12.0),
                      itemBuilder: (context, index) {
                        return WorkoutProgramCard(
                          program: filteredPrograms[index],
                        );
                      },
                    ),
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
                setState(() {
                  currentNavIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
