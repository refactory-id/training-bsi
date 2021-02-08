import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/main.dart';
import 'package:flutter_encrypt_local_storage/models/user_model.dart';
import 'package:flutter_encrypt_local_storage/repos/auth_repo.dart';
import 'package:flutter_encrypt_local_storage/states/base_state.dart';
import 'package:flutter_encrypt_local_storage/utils/string_util.dart';
import 'package:hive/hive.dart';

class AuthProvider extends ChangeNotifier {
  ViewState _state = Idle();
  ViewState get state => _state;
  set state(ViewState state) {
    if (_state == state) return;

    _state = state;
    notifyListeners();
  }

  final Box<dynamic> _box;
  final AuthRepository _repository;

  AuthProvider(this._repository, this._box);

  void _saveUser(UserModel user) {
    _box.putAll({
      "name": encode(user.name),
      "email": encode(user.email),
      "token": encode("Bearer ${user.token}")
    });
  }

  void login(String email, String password, Function onSuccess) async {
    state = Loading();

    try {
      final user =
          await _repository.login({"email": email, "password": password});
      _saveUser(user);

      state = Success();

      onSuccess();
    } catch (e) {
      if (MyApp.isDebug) print("Error: $e");

      if (e is DioError) {
        if (e.response != null) {
          state = Error(e.response.data["data"] ?? "Oops something went wrong");
        } else {
          state = Error(e.message);
        }
      } else {
        state = Error(e?.message ?? "Oops something went wrong");
      }

      Future.delayed(Duration(seconds: 3), () => state = Idle());
    }
  }

  void register(
      String email, String password, String name, Function onSuccess) async {
    state = Loading();

    try {
      final user = await _repository
          .register({"email": email, "password": password, "name": name});
      _saveUser(user);

      state = Success();

      onSuccess();
    } catch (e) {
      if (MyApp.isDebug) print("Error: $e");

      if (e is DioError) {
        if (e.response != null) {
          state = Error(e.response.data["data"] ?? "Oops something went wrong");
        } else {
          state = Error(e.message);
        }
      } else {
        state = Error(e?.message ?? "Oops something went wrong");
      }

      Future.delayed(Duration(seconds: 3), () => state = Idle());
    }
  }
}
