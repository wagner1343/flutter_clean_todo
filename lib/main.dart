import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/flutter_todo_app.dart';
import 'package:flutter_clean_todo/setup_get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupGetIt();
  runApp(getIt.get<FlutterTodoApp>());
}
