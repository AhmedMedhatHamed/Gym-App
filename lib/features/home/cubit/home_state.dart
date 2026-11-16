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
  final String userName;

  HomeLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.filteredPrograms,
    this.searchQuery = '',
    this.userName = '',
  });

  HomeLoaded copyWith({
    List<String>? categories,
    String? selectedCategory,
    List<WorkoutProgramModel>? filteredPrograms,
    String? searchQuery,
    String? userName,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredPrograms: filteredPrograms ?? this.filteredPrograms,
      searchQuery: searchQuery ?? this.searchQuery,
      userName: userName ?? this.userName,
    );
  }
}

final class HomeError extends HomeState {
  final String errorMsg;

  HomeError(this.errorMsg);
}
