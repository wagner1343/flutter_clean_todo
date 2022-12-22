import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page.dart';
import 'package:flutter_clean_todo/flutter/pages/register/register_page.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page.dart';
import 'package:flutter_clean_todo/getx/components/getx_redirect.dart';
import 'package:flutter_clean_todo/getx/middleware/auth/authenticated_only_guard.dart';
import 'package:flutter_clean_todo/getx/middleware/auth/guest_only_guard.dart';
import 'package:flutter_clean_todo/ioc/locator.dart';
import 'package:get/get.dart';

List<GetPage> buildRoutes(Locator locator) => [
      useNodeLevelAsMiddlewarePriority(GetPage(
          name: "/",
          page: () => GetxRedirect(
              redirectSettings: RedirectSettings(toName: "/login")),
          children: [
            GetPage(
              name: '/login',
              page: () => locator.get<LoginPage>(),
              transition: Transition.fade,
              middlewares: [
                GuestOnlyGuard("/todos", locator.get<AuthService>())
              ],
            ),
            GetPage(
              name: '/register',
              page: () => locator.get<RegisterPage>(),
              transition: Transition.fade,
              middlewares: [
                GuestOnlyGuard("/todos", locator.get<AuthService>())
              ],
            ),
            GetPage(
              name: '/todos',
              page: () => locator.get<TodosPage>(),
              transition: Transition.fade,
              middlewares: [
                AuthenticatedOnlyGuard("/", locator.get<AuthService>())
              ],
            ),
            GetPage(
              name: '/todos/create',
              page: () => locator.get<CreateTodoPage>(),
              transition: Transition.fade,
              middlewares: [
                AuthenticatedOnlyGuard("/", locator.get<AuthService>())
              ],
            ),
          ]))
    ];

GetPage useNodeLevelAsMiddlewarePriority(GetPage page, {int currentLevel = 1}) {
  page.middlewares?.forEach((e) {
    e.priority = currentLevel;
  });
  page.children.forEach((c) {
    useNodeLevelAsMiddlewarePriority(c, currentLevel: currentLevel + 1);
  });
  return page;
}
