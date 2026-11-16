import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:gym_app/core/datasource/hive_data_source.dart';
import 'package:gym_app/core/services/step_tracking_service.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:material_ui/material_ui.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({FirebaseDataSource? firebaseDataSource})
      : _firebaseDataSource = firebaseDataSource ?? FirebaseDataSource(),
        super(HomeInitial()) {
    initHome();
  }

  final FirebaseDataSource _firebaseDataSource;

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  final List<String> _categories = workoutCategories;
  final List<WorkoutProgramModel> _allPrograms = workoutPrograms;

  String _selectedCategory = workoutCategories.first;
  String _searchQuery = '';
  String _userName = HiveDataSource.getUserName() ?? userNameNotifier.value;

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  List<WorkoutProgramModel> get allPrograms => _allPrograms;
  String get searchQuery => _searchQuery;
  String get userName => _userName;

  void initHome() {
    _emitLoadedState();
    loadUserData();
    StepTrackingService.instance.init();
  }

  Future<void> loadUserData() async {
    try {
      final user = await _firebaseDataSource.getUserData();
      if (user != null && user.name.isNotEmpty) {
        _userName = user.name;
        await HiveDataSource.saveUserName(user.name);
        userNameNotifier.value = user.name;
        _emitLoadedState();
      }
    } catch (_) {}
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
        userName: _userName,
      ),
    );
  }
}
