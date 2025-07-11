import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:techrar_task/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:techrar_task/features/dashboard/presentation/screens/main_screen.dart';
import 'package:techrar_task/features/profile/presentation/screens/profile_screen.dart';
import 'package:techrar_task/features/tasks/presentation/screens/tasks_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: TasksRoute.page,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
          ],
        ),
      ];
}
