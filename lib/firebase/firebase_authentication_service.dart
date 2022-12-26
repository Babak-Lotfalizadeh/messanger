import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/screens/login_screen.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/response_api.dart';

class FirebaseAuthenticationService {
  static FirebaseAuth? _auth;
  static final FirebaseAuthenticationService _instance =
      FirebaseAuthenticationService._internal();

  factory FirebaseAuthenticationService() {
    return _instance;
  }

  FirebaseAuthenticationService._internal();

  Future<void> init() async {
    _auth = FirebaseAuth.instance;
    _auth?.userChanges().listen(_onUserStatusChanged);
  }

  User? get currentUser => _auth?.currentUser;

  void _onUserStatusChanged(User? user) {
    log('user = $user');
    if (user == null) {
      NavigationService.pushAndReplace(const LoginScreen());
    }
  }

  Future<ResponseAPI> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await _auth?.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return ResponseAPI.success(response: credential);
    } on FirebaseAuthException catch (e) {
      return ResponseAPI.error(error: e.code);
    } catch (e) {
      return ResponseAPI.error(error: e.toString());
    }
  }

  Future<ResponseAPI> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await _auth?.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return ResponseAPI.success(response: credential);
    } on FirebaseAuthException catch (e) {
      return ResponseAPI.error(error: e.code);
    } catch (e) {
      return ResponseAPI.error(error: e.toString());
    }
  }

  Future<ResponseAPI> forgotPassword({
    required String emailAddress,
  }) async {
    try {
      await _auth?.sendPasswordResetEmail(
        email: emailAddress,
      );
      return ResponseAPI.success(response: true);
    } on FirebaseAuthException catch (e) {
      return ResponseAPI.error(error: e.code);
    } catch (e) {
      return ResponseAPI.error(error: e.toString());
    }
  }

  Future<void> signOut() => FirebaseAuth.instance.signOut();
}
