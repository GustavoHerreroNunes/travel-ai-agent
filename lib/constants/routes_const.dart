import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_ai_agent/features/home/presentation/pages/home_page.dart';
import 'package:travel_ai_agent/features/logIn/presentation/pages/login_page.dart';

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to HomePage');
        return const HomePage();
      },
    ),
  ],
);