import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/add_post/add_post_cubit.dart';
import 'package:flutter_sample_app/presentation/widgets/my_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class AddPostView extends StatefulWidget {
  final AddPostCubit addPostCubit;
  const AddPostView({super.key, required this.addPostCubit});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final userIdTEC = TextEditingController();
  final titleTEC = TextEditingController();
  final bodyTEC = TextEditingController();

  @override
  void dispose() {
    userIdTEC.dispose();
    titleTEC.dispose();
    bodyTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.addPostCubit,
      child: AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              if (state.status == AddPostStatus.loading) {
                return const BoxUi(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state.status == AddPostStatus.noInternet) {
                return const BoxUi(
                  child: Center(
                    child: Text('No internet'),
                  ),
                );
              }
              if (state.status == AddPostStatus.failure) {
                return const BoxUi(
                  child: Center(
                    child: Text('Cannot add post'),
                  ),
                );
              }
              if (state.status == AddPostStatus.success) {
                return BoxUi(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Added the post successfully'),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        key: const ValueKey('ok-success'),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
              if (state.status == AddPostStatus.initial) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //user id
                    MyTextField(
                      tec: userIdTEC,
                      label: 'Enter user id',
                      textInputType: TextInputType.number,
                      textFieldKey: 'userId',
                    ),
                    const SizedBox(
                      height: 4,
                    ),

                    //title
                    MyTextField(
                      tec: titleTEC,
                      label: 'Enter title',
                      textFieldKey: 'title',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    //body
                    MyTextField(
                      tec: bodyTEC,
                      label: 'Body',
                      textFieldKey: 'body',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //upload
                    ElevatedButton(
                      onPressed: () {
                        final post = Post(
                          userId: int.parse(userIdTEC.text),
                          title: titleTEC.text,
                          body: bodyTEC.text,
                        );
                        context.read<AddPostCubit>().addPost(post);
                      },
                      child: const Text('Upload'),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class BoxUi extends StatelessWidget {
  const BoxUi({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.55,
      height: sw * 0.55,
      child: child,
    );
  }
}
