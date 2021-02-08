import 'package:flutter_encrypt_local_storage/repos/auth_repo.dart';
import 'package:flutter_encrypt_local_storage/services/auth_service.dart';
import 'package:injector/injector.dart';

class RepositoryModule {
  static void init(Injector injector) {
    injector.registerSingleton<AuthRepository>(
        () => AuthRepositoryImpl(injector.get<AuthService>()));
  }
}
