import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:material_ui/material_ui.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await firebaseDataSource.login(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? 'Something went wrong'));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
