import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:gym_app/core/datasource/hive_data_source.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:material_ui/material_ui.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignupLoading());
    try {
      await firebaseDataSource.signup(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      await HiveDataSource.saveUserName(name);
      userNameNotifier.value = name;
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(e.message ?? 'Something went wrong'));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
