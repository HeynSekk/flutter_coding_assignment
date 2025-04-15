import 'package:flutter_sample_app/features/sample_feature_1/sample_cubit.dart';
import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:user_repository/user_repository.dart';

Future<void> setupLocator() async {
  getIt.registerSingleton<ConnectionUtil>(ConnectionUtil());
  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerLazySingleton<JsonGenerator>(() => JsonGenerator());
  getIt.registerSingleton<SampleCubit>(
      SampleCubit(getIt<UserRepository>(), getIt<JsonGenerator>()));

  getIt.registerSingleton<SampleCubit2>(
      SampleCubit2(getIt<UserRepository>(), getIt<JsonGenerator>()));

  getIt.registerSingleton<SampleCubit3>(
      SampleCubit3(getIt<UserRepository>(), getIt<JsonGenerator>()));

  getIt.registerSingleton<SampleCubit4>(
      SampleCubit4(getIt<UserRepository>(), getIt<JsonGenerator>()));

  getIt.registerSingleton<SampleCubit5>(
      SampleCubit5(getIt<UserRepository>(), getIt<JsonGenerator>()));
}
