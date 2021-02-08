import 'package:flutter_encrypt_local_storage/services/api_service.dart';

abstract class AuthService {
  Future<Map<String, dynamic>> login(Map<String, dynamic> body);
  Future<Map<String, dynamic>> register(Map<String, dynamic> body);
}

class AuthServiceImpl implements AuthService {
  final ApiService _service;
  final String _login = "v1/signin";
  final String _register = "v1/signup";

  AuthServiceImpl(this._service);

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> body) {
    return _service.call(_login, RequestType.POST, body: body);
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> body) {
    return _service.call(_register, RequestType.POST, body: body);
  }
}
