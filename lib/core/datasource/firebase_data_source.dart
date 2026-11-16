import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app/features/auth/model/user_model.dart';

class FirebaseDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
            UserModel(
              uid: userCredential.user!.uid,
              email: email,
              name: name,
              phone: phone,
            ).toJson(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserModel?> getUserData([String? uid]) async {
    final userId = uid ?? _auth.currentUser?.uid;
    if (userId == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
    } catch (e) {
      log('Error getting user data: $e');
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> forgotPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
