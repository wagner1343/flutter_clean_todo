import 'package:flutter_clean_todo/application/auth/auth_user.dart';

abstract class AuthService {
  Future<void> registerWithEmailAndPassword(
      {required name, required String email, required String password});

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Stream<AuthUser?> get currentUserStream;

  AuthUser? get currentUser;
}
