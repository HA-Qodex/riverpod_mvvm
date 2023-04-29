import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_mvvm/routes/route_name.dart';
import 'package:riverpod_mvvm/ui/views/home/view.dart';
import 'package:riverpod_mvvm/ui/views/todo/view.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final appRouter = GoRouter(navigatorKey: _rootNavigationKey, routes: [
  GoRoute(
      path: '/',
      name: AppRoutes.home,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
            path: 'todo',
            name: AppRoutes.todo,
            parentNavigatorKey: _rootNavigationKey,
            pageBuilder: (context, state) => CustomTransitionPage(
                child: const TodoView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeIn)),
                          ),
                          child: child,
                        )))
      ])
]);
