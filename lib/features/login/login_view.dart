import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/presentation/widgets/my_text_field.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final LoginCubit loginCubit;
  const LoginPage({super.key, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailTec = TextEditingController();
  final pwdTec = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginCubit>().init();
    });
    super.initState();
  }

  @override
  void dispose() {
    emailTec.dispose();
    pwdTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.success ||
                  state.status == LoginStatus.alreadyLogin) {
                context.goNamed('users-list');
                return;
              }
            },
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state.status == LoginStatus.loading ||
                    state.status == LoginStatus.success ||
                    state.status == LoginStatus.alreadyLogin) {
                  return const CircularProgressIndicator();
                }
                if (state.status == LoginStatus.noInternet) {
                  return const Text('No internet');
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextField(
                      tec: emailTec,
                      label: 'Enter email',
                      textFieldKey: 'email',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MyTextField(
                      tec: pwdTec,
                      label: 'Enter password',
                      textFieldKey: 'pwd',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                              email: emailTec.text,
                              password: pwdTec.text,
                            );
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      _getMessage(state.status),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _getMessage(LoginStatus loginStatus) {
    if (loginStatus == LoginStatus.failure) {
      return 'Cannot login';
    }
    if (loginStatus == LoginStatus.authCheckFailure) {
      return 'You need to login';
    }
    return '';
  }
}
