import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dev_test/features/home/presentation/pages/home_page.dart';
import 'package:flutter_dev_test/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_dev_test/features/auth/presentation/pages/recovery_secret_page.dart';

class AppRouter {
  final AuthBloc authBloc;
  late final GoRouter router;

  AppRouter(this.authBloc) {
    router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/recover-secret',
          builder: (context, state) => const RecoverySecretPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool isAuthenticated = authBloc.state is AuthSuccess;

        final isLoginPage = state.uri.path == '/login';

        if (isAuthenticated && isLoginPage) {
          return '/home';
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }
}
