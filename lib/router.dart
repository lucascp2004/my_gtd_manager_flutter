import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/pages/home.dart';
import 'package:my_gtd_manager_2/pages/lists_page.dart';
import 'package:my_gtd_manager_2/pages/login_screen.dart';
import 'package:my_gtd_manager_2/pages/planner.dart';
import 'package:my_gtd_manager_2/pages/signup_page.dart';
import 'package:my_gtd_manager_2/pages/todolist_page.dart';

import 'pages/list_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(child: HomePage()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      routes: [
        GoRoute(
          path: 'signup',
          pageBuilder: (context, state) => MaterialPage(child: SignupPage()),
        ),
      ],
    ),
    GoRoute(
      path: "/todolists",
      pageBuilder: (context, state) => MaterialPage(
        child: ListsPage(
          option: PageOptions.todoListsPage,
          stream: DatabaseDao.todoListsStream(),
          orderList: DatabaseDao.myListsOrderded,
        ),
      ),
      routes: [
        GoRoute(
          path: 'list/:index',
          pageBuilder: (context, state) {
            final index = state.pathParameters['index']!;
            return MaterialPage(child: TodoListPage(int.parse(index)));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/lists',
      pageBuilder: (context, state) {
        return MaterialPage(
          child: ListsPage(
            option: PageOptions.projects,
            stream: DatabaseDao.listsStream(),
            orderList: DatabaseDao.myListsOrderded,
          ),
        );
      },
      routes: [
        GoRoute(
          path: 'list/:index',
          pageBuilder: (context, state) {
            final index = state.pathParameters['index']!;
            return MaterialPage(child: ListPage(int.parse(index)));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/planner',
      //pageBuilder: (context, state) => MaterialPage(child: PlannerPage()),
      pageBuilder: (context, state) => MaterialPage(child: PlannerPage()),
    ),
  ],
);
