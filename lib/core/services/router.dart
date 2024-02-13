import 'package:dashboard_bloc_tdd/core/common/views/page_under_construction.dart';
import 'package:dashboard_bloc_tdd/core/extensions/context_extension.dart';
import 'package:dashboard_bloc_tdd/core/services/injection_container.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/views/sign_in_screen.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/views/sign_up_screen.dart';
import 'package:dashboard_bloc_tdd/src/dashboard/presentation/views/dashboard.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      // sl accessing because of init() in main
      final prefs = sl<SharedPreferences>();

      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );

            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );

    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
