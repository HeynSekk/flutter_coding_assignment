import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:user_repository/user_repository.dart';

Future<void> setupLocator() async {
  getIt.registerSingleton<ConnectionUtil>(ConnectionUtil());
  getIt.registerSingleton<UserRepository>(UserRepository());
  // getIt.registerSingleton<Auth>(Auth(FirebaseAuth.instance));
  // getIt.registerLazySingleton<JsonGenerator>(() => JsonGenerator());
}
