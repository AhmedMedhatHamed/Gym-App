import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:gym_app/core/datasource/hive_data_source.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    ImagePicker? imagePicker,
    FirebaseDataSource? firebaseDataSource,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _firebaseDataSource = firebaseDataSource ?? FirebaseDataSource(),
        super(
          ProfileLoaded(
            avatarBytes:
                HiveDataSource.getProfileImage() ?? profileImageNotifier.value,
            badges: profileBadges,
            workoutLogs: profileWorkoutLogs,
            userName:
                HiveDataSource.getUserName() ?? userNameNotifier.value,
          ),
        ) {
    loadUserData();
  }

  final ImagePicker _imagePicker;
  final FirebaseDataSource _firebaseDataSource;

  static ProfileCubit get(BuildContext context) =>
      BlocProvider.of<ProfileCubit>(context);

  ProfileLoaded get _currentState {
    if (state is ProfileLoaded) {
      return state as ProfileLoaded;
    } else if (state is ProfileActionError) {
      return (state as ProfileActionError).previousState;
    }
    return ProfileLoaded(
      avatarBytes:
          HiveDataSource.getProfileImage() ?? profileImageNotifier.value,
      badges: profileBadges,
      workoutLogs: profileWorkoutLogs,
      userName: HiveDataSource.getUserName() ?? userNameNotifier.value,
    );
  }

  Future<void> loadUserData() async {
    try {
      final user = await _firebaseDataSource.getUserData();
      if (user != null && user.name.isNotEmpty) {
        await HiveDataSource.saveUserName(user.name);
        userNameNotifier.value = user.name;
        emit(_currentState.copyWith(userName: user.name));
      }
    } catch (_) {}
  }

  void selectBadge(int index) {
    if (_currentState.selectedBadgeIndex == index) return;
    emit(_currentState.copyWith(selectedBadgeIndex: index));
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (picked == null) return;

      final Uint8List bytes = await picked.readAsBytes();
      await HiveDataSource.saveProfileImage(bytes);
      profileImageNotifier.value = bytes;
      emit(_currentState.copyWith(avatarBytes: () => bytes));
    } on MissingPluginException {
      emit(
        ProfileActionError(
          message: 'يرجى إعادة تشغيل التطبيق بالكامل لتفعيل اختيار الصور',
          previousState: _currentState,
        ),
      );
    } on PlatformException catch (e) {
      emit(
        ProfileActionError(
          message: e.message ?? 'تعذر الوصول إلى الصور، تأكد من الصلاحيات',
          previousState: _currentState,
        ),
      );
    } catch (_) {
      emit(
        ProfileActionError(
          message: 'حدث خطأ أثناء اختيار الصورة',
          previousState: _currentState,
        ),
      );
    }
  }

  Future<void> removeAvatar() async {
    await HiveDataSource.deleteProfileImage();
    profileImageNotifier.value = null;
    emit(_currentState.copyWith(avatarBytes: () => null));
  }

  Future<void> logout() async {
    final current = _currentState;
    emit(current.copyWith(isLoggingOut: true));
    try {
      await _firebaseDataSource.logout();
      emit(ProfileLogoutSuccess());
    } catch (e) {
      emit(
        ProfileActionError(
          message: e.toString(),
          previousState: current.copyWith(isLoggingOut: false),
        ),
      );
    }
  }
}
