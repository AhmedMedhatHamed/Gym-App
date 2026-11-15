import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoading());

    try {
      await firebaseDataSource.forgotPassword(
        email: email,
      );

      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        ForgotPasswordFailure(
          e.message ?? 'Something went wrong',
        ),
      );
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
