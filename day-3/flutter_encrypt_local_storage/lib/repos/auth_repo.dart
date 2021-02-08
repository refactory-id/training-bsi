import 'package:flutter_encrypt_local_storage/models/user_model.dart';
import 'package:flutter_encrypt_local_storage/services/auth_service.dart';

abstract class AuthRepository {
  Future<UserModel> login(Map<String, dynamic> body);
  Future<UserModel> register(Map<String, dynamic> body);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<UserModel> login(Map<String, dynamic> body) {
    return _service
        .login(body)
        .then((json) => UserModel.fromJson(json["data"]));
  }

  @override
  Future<UserModel> register(Map<String, dynamic> body) {
    return _service
        .register(body)
        .then((json) => UserModel.fromJson(json["data"]));
  }
}
