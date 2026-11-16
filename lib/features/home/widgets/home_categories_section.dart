import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/home/cubit/home_cubit.dart';
import 'package:gym_app/features/home/widgets/category_chips.dart';
import 'package:material_ui/material_ui.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        if (previous is HomeLoaded && current is HomeLoaded) {
          return previous.selectedCategory != current.selectedCategory ||
              previous.categories != current.categories;
        }
        return true;
      },
      builder: (context, state) {
        return switch (state) {
          HomeLoaded(:final categories, :final selectedCategory) =>
            CategoryChips(
              categories: categories,
              selectedCategory: selectedCategory,
              onSelected: (category) {
                context.read<HomeCubit>().selectCategory(category);
              },
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
