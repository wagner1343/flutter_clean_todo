import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/auth/auth_user.dart';

extension FirebaseUserExtensions on User {
  AuthUser toAuthUser() => AuthUser(id: uid, name: displayName);
}
