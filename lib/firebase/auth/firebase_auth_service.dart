import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/application/auth/auth_user.dart';
import 'package:flutter_clean_todo/firebase/auth/firebase_auth_extensions.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> loginWithGoogle() async {
    await _firebaseAuth.signInWithProvider(GoogleAuthProvider());
  }

  @override
  Future<void> registerWithEmailAndPassword(
      {required name, required String email, required String password}) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = credentials.user;
    if (user != null) {
      await user.updateDisplayName(name);
    }
  }

  @override
  AuthUser? get currentUser => _firebaseAuth.currentUser?.toAuthUser();

  @override
  Stream<AuthUser?> get currentUserStream =>
      _firebaseAuth.userChanges().map((u) => u?.toAuthUser());

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
