import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_sample_app/features/login/auth.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/features/login/login_view.dart';
import 'package:flutter_sample_app/features/sample_feature_1/sample_screen.dart';
import 'package:flutter_sample_app/features/user_detail/user_detail_view.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_sample_app/features/users_list/users_list_view.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart' hide User;

import '../models/user.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'login',
      path: '/',
      builder: (context, state) {
        return LoginPage(
          loginCubit: LoginCubit(Auth(FirebaseAuth.instance)),
        );
      },
    ),
    GoRoute(
      name: 'users-list',
      path: '/users-list',
      builder: (context, state) {
        return UserListPage(
          userListCubit: UserListCubit(
            getIt<UserRepository>(),
            JsonGenerator(),
          ),
          loginCubit: LoginCubit(Auth(FirebaseAuth.instance)),
        );
      },
    ),
    GoRoute(
      name: 'user-detail',
      path: '/user-detail',
      builder: (context, state) {
        User user = state.extra as User;
        return UserDetailPage(user: user);
      },
    ),
    GoRoute(
      name: 'sample-screen',
      path: '/sample-screen',
      builder: (context, state) {
        return const SampleScreen();
      },
    ),
    GoRoute(
      name: 'sample-screen2',
      path: '/sample-screen2',
      builder: (context, state) {
        return const SampleScreen2();
      },
    ),
    GoRoute(
      name: 'sample-screen3',
      path: '/sample-screen3',
      builder: (context, state) {
        return const SampleScreen3();
      },
    ),
    GoRoute(
      name: 'sample-screen4',
      path: '/sample-screen4',
      builder: (context, state) {
        return const SampleScreen4();
      },
    ),
    GoRoute(
      name: 'sample-screen5',
      path: '/sample-screen5',
      builder: (context, state) {
        return const SampleScreen5();
      },
    ),
  ],
);
