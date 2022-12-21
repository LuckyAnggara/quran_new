import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:reverpod/view/MainPage.dart';
import 'package:reverpod/view/SuratPage.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'surat',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SuratPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
  ],
);
