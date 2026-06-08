import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_sample_app/util/exception_handler.dart';

/// Functions in this method throws `FirebaseAuthException` if login fails.
/// It can throw other exceptions with an error message as well.
class Auth {
  // Auth({FirebaseAuth? firebaseAuth})
  //     : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Auth(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Future<bool> isAuthenticated() async {
    try {
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
    } on Exception catch (e) {
      throw ExceptionHandler.refineException(e);
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      throw ExceptionHandler.refineException(e);
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      throw ExceptionHandler.refineException(e);
    }
  }
}
