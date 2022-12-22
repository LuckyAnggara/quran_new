import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:reverpod/view/JadwalSolat.dart';
import 'package:reverpod/view/MainPage.dart';
import 'package:reverpod/view/ReadSuratPage.dart';
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
        GoRoute(
          path: 'jadwal',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: JadwalSolat(),
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
        GoRoute(
          name: 'baca',
          path: 'baca-surat/:nomor',
          pageBuilder: (context, state) {
            print(state.params);
            return CustomTransitionPage(
              key: state.pageKey,
              child: ReadSuratPage(
                nomor: state.params['nomor'],
              ),
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
