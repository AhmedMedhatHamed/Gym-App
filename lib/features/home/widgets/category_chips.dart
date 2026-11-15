import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onSelected(category),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.chipColor,
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: Text(
                category,
                style: AppStyles.noto700Size16.copyWith(
                  fontSize: 13.0,
                  color: isSelected ? AppColors.backgroundColor : AppColors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
