import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';

class Auth {
  Auth({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<bool> isAuthenticated() async {
    final connUtil = getIt<ConnectionUtil>();
    final isConnected = await connUtil.isConnected();
    if (!isConnected) {
      if (_firebaseAuth.currentUser == null) {
        return false;
      } else {
        return true;
      }
    }
    final idToken = await _firebaseAuth.currentUser?.getIdToken(true);
    if (idToken == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
