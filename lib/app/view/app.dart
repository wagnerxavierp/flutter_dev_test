import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/app/router/app_router.dart';
import 'package:flutter_dev_test/core/theme/app_themes.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/auth_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dev Flutter Test',
      theme: AppThemes.lightTheme,
      routerConfig: AppRouter(context.read<AuthBloc>()).router,
      debugShowCheckedModeBanner: false,
    );
  }
}
