import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/add_post/add_post_cubit.dart';
import 'package:flutter_sample_app/features/add_post/add_post_view.dart';
import 'package:flutter_sample_app/features/login/login_cubit.dart';
import 'package:flutter_sample_app/features/users_list/user_list_cubit.dart';
import 'package:flutter_sample_app/features/users_list/widgets/user_card.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class UserListPage extends StatelessWidget {
  final UserListCubit userListCubit;
  final LoginCubit loginCubit;
  const UserListPage(
      {super.key, required this.userListCubit, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => userListCubit,
        ),
        BlocProvider.value(
          value: loginCubit,
        )
      ],
      child: const UserListView(),
    );
  }
}

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    context.read<UserListCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Assignment'),
        actions: [
          PopupMenuButton(
            key: const ValueKey('popupMenuButton'),
            onSelected: (val) {
              //json
              if (val == 0) {
                context.read<UserListCubit>().generateJson();
                return;
              }
              //logout
              if (val == 1) {
                context.read<LoginCubit>().logout();
                return;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Generate JSON'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.logoutSuccess) {
            context.goNamed('login');
            return;
          }
        },
        child: BlocBuilder<UserListCubit, UserListState>(
          builder: (context, state) {
            if (state.status == UserListStatus.noInternet ||
                state.status == UserListStatus.failure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.status == UserListStatus.noInternet
                        ? 'No internet'
                        : 'Cannot fetch users'),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserListCubit>().fetchUsers();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state.status == UserListStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      JsonGenerationStatus(
                        userListStatus: state.status,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: state.users
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  child: UserInfoCard(user: e),
                                  onTap: () {
                                    context.pushNamed('user-detail', extra: e);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload, semanticLabel: 'Upload'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddPostView(
                addPostCubit: AddPostCubit(getIt<UserRepository>()),
              );
            },
          );
        },
      ),
    );
  }
}

class JsonGenerationStatus extends StatelessWidget {
  const JsonGenerationStatus({super.key, required this.userListStatus});
  final UserListStatus userListStatus;

  String _getMessage(UserListStatus userListStatus) {
    if (userListStatus == UserListStatus.jsonGenerateFailure) {
      return "Json Generation Failed!";
    }
    if (userListStatus == UserListStatus.jsonGenerateSuccess) {
      return "Json Generation Succeeded!";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (!(userListStatus == UserListStatus.jsonGenerateFailure ||
        userListStatus == UserListStatus.jsonGenerateSuccess)) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: const Color.fromARGB(
            255, 249, 236, 252), // Light purple color for the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        elevation: 4, // Shadow effect
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _getMessage(userListStatus),
            style: TextStyle(
              fontSize: 16,
              color: userListStatus == UserListStatus.jsonGenerateSuccess
                  ? Colors.black
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
