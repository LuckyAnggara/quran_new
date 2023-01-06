import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/models/surat.dart';
import 'package:reverpod/view/CompasPage.dart';
import 'package:reverpod/view/LocationPage.dart';
import 'package:reverpod/view/NotFoundPage.dart';
import 'package:reverpod/view/FontSetting.dart';
import 'package:reverpod/view/JadwalSolat.dart';
import 'package:reverpod/view/MainPage.dart';
import 'package:reverpod/view/ReadSuratPage.dart';
import 'package:reverpod/view/SuratPage.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const MainPage();
    },
    routes: <RouteBase>[
      GoRoute(
        path: 'surat',
        name: 'surat',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SuratPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
              path: 'baca',
              name: 'baca',
              pageBuilder: (context, state) {
                Object? object = state.extra;
                if (object != null && object is Surat) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ReadSuratPage(
                      surat: object,
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
                }
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const NotFoundPage(),
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
              routes: [
                GoRoute(
                  name: 'fontSetting',
                  path: 'font-setting',
                  pageBuilder: (context, state) {
                    print('keSetting');
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const FontSizeScreenSetting(),
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
              ]),
        ],
      ),
      GoRoute(
        path: 'kota',
        name: 'kota',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LocationPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: 'jadwal-sholat',
        path: 'jadwal',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: JadwalSolat(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: 'compas',
        name: 'compas',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: CompasPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  ),
], initialLocation: '/', debugLogDiagnostics: true);
