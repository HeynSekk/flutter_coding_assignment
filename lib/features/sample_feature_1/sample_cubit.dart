import 'package:flutter_sample_app/main.dart';
import 'package:flutter_sample_app/util/connection_util.dart';
import 'package:flutter_sample_app/util/json_generator.dart';
import 'package:user_repository/user_repository.dart' as repo;

class SampleCubit {
  SampleCubit(this._userRepository, this._jsonGenerator);
  final repo.UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (1 == 2) {
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userRepository.getUsers();
    } on Exception {}
  }

  Future<void> generateJson() async {
    try {
      await _jsonGenerator.generateJson([]);
    } on Exception {}
  }
}

class SampleCubit2 {
  SampleCubit2(this._userRepository, this._jsonGenerator);
  final repo.UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (1 == 2) {
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userRepository.getUsers();
    } on Exception {}
  }

  Future<void> generateJson() async {
    try {
      await _jsonGenerator.generateJson([]);
    } on Exception {}
  }
}

class SampleCubit3 {
  SampleCubit3(this._userRepository, this._jsonGenerator);
  final repo.UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (1 == 2) {
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userRepository.getUsers();
    } on Exception {}
  }

  Future<void> generateJson() async {
    try {
      await _jsonGenerator.generateJson([]);
    } on Exception {}
  }
}

class SampleCubit4 {
  SampleCubit4(this._userRepository, this._jsonGenerator);
  final repo.UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (1 == 2) {
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userRepository.getUsers();
    } on Exception {}
  }

  Future<void> generateJson() async {
    try {
      await _jsonGenerator.generateJson([]);
    } on Exception {}
  }
}

class SampleCubit5 {
  SampleCubit5(this._userRepository, this._jsonGenerator);
  final repo.UserRepository _userRepository;
  final JsonGenerator _jsonGenerator;

  Future<void> init() async {
    final isConnected = await getIt<ConnectionUtil>().isConnected();
    if (isConnected) {
      fetchUsers();
      return;
    }
    //this mean we have data in local db
    if (1 == 2) {
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userRepository.getUsers();
    } on Exception {}
  }

  Future<void> generateJson() async {
    try {
      await _jsonGenerator.generateJson([]);
    } on Exception {}
  }
}
