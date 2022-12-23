import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/application/todo/todos_service.dart';
import 'package:flutter_clean_todo/infra/firebase/auth/firebase_auth_service.dart';
import 'package:flutter_clean_todo/infra/firebase/todos/firebase_todos_service.dart';
import 'package:flutter_clean_todo/flutter/flutter_todo_app.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page_presenter.dart';
import 'package:flutter_clean_todo/flutter/pages/register/register_page.dart';
import 'package:flutter_clean_todo/flutter/pages/register/register_page_presenter.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page_presenter.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page_presenter.dart';
import 'package:flutter_clean_todo/infra/get_it/get_it_locator.dart';
import 'package:flutter_clean_todo/infra/getx/components/app_builder/getx_app_builder.dart';
import 'package:flutter_clean_todo/infra/getx/components/app_builder/getx_app_builder_args.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/login/getx_login_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/register/getx_register_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/todos/create_todo/getx_create_todo_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/todos/getx_todos_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/routes.dart';
import 'package:flutter_clean_todo/ioc/locator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // GetIt ====================================================================
  getIt.registerLazySingleton<Locator>(() => GetItLocator(getIt));

  // Firebase =================================================================
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // = Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthService>(
      () => FirebaseAuthService(getIt<FirebaseAuth>()));

  // = Todos
  getIt.registerLazySingleton<TodosService>(() => FirebaseTodosService(
      getIt.get<FirebaseFirestore>(), getIt.get<FirebaseAuth>()));

  // GetX =====================================================================
  // = Presenters
  // = = Login
  getIt.registerFactory<LoginPagePresenter>(
      () => GetxLoginPresenter(getIt.get<AuthService>()));

  // = = Register
  getIt.registerFactory<RegisterPagePresenter>(
      () => GetxRegisterPresenter(getIt.get<AuthService>()));

  // = = Todos
  getIt.registerFactory<TodosPagePresenter>(() =>
      GetxTodoPresenter(getIt.get<TodosService>(), getIt.get<AuthService>()));

  // = = = Create Todo
  getIt.registerFactory<CreateTodoPagePresenter>(
      () => GetxCreateTodoPresenter(getIt.get<TodosService>()));

  // Routes
  getIt.registerLazySingleton<List<GetPage>>(
      () => buildRoutes(getIt.get<Locator>()));

  // Components
  // = AppBuilder
  getIt.registerLazySingleton(
      () => GetxAppBuilderArgs("Flutter Todo", getIt.get<List<GetPage>>()));
  getIt.registerLazySingleton(
      () => GetxAppBuilder(getIt.get<GetxAppBuilderArgs>()));

  // App ======================================================================
  getIt.registerFactory(() => LoginPage(getIt.get<LoginPagePresenter>()));
  getIt.registerFactory(() => RegisterPage(getIt.get<RegisterPagePresenter>()));
  getIt.registerFactory(() => TodosPage(getIt.get<TodosPagePresenter>()));
  getIt.registerFactory(
      () => CreateTodoPage(getIt.get<CreateTodoPagePresenter>()));
  getIt.registerFactory(
      () => FlutterTodoApp(appBuilder: getIt.get<GetxAppBuilder>()));
}
