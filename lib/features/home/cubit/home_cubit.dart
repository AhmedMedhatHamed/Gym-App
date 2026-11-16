import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';
import 'package:material_ui/material_ui.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    initHome();
  }

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  final List<String> _categories = workoutCategories;
  final List<WorkoutProgramModel> _allPrograms = workoutPrograms;

  String _selectedCategory = workoutCategories.first;
  String _searchQuery = '';

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  List<WorkoutProgramModel> get allPrograms => _allPrograms;
  String get searchQuery => _searchQuery;

  void initHome() {
    _emitLoadedState();
  }

  void selectCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    _emitLoadedState();
  }

  void searchWorkouts(String query) {
    _searchQuery = query;
    _emitLoadedState();
  }

  void _emitLoadedState() {
    final filtered = _allPrograms.where((program) {
      final matchesCategory = program.category == _selectedCategory;
      if (_searchQuery.trim().isEmpty) {
        return matchesCategory;
      }
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = program.title.toLowerCase().contains(query) ||
          program.level.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    emit(
      HomeLoaded(
        categories: _categories,
        selectedCategory: _selectedCategory,
        filteredPrograms: filtered,
        searchQuery: _searchQuery,
      ),
    );
  }
}
