part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<String> categories;
  final String selectedCategory;
  final List<WorkoutProgramModel> filteredPrograms;
  final String searchQuery;

  HomeLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.filteredPrograms,
    this.searchQuery = '',
  });

  HomeLoaded copyWith({
    List<String>? categories,
    String? selectedCategory,
    List<WorkoutProgramModel>? filteredPrograms,
    String? searchQuery,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredPrograms: filteredPrograms ?? this.filteredPrograms,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final class HomeError extends HomeState {
  final String errorMsg;

  HomeError(this.errorMsg);
}
