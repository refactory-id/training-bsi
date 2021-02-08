import 'package:flutter_encrypt_local_storage/di/modules/network_module.dart';
import 'package:flutter_encrypt_local_storage/di/modules/repository_module.dart';
import 'package:injector/injector.dart';

class AppComponent {
  static void init() {
    NetworkModule.init(injector);
    RepositoryModule.init(injector);
  }

  static Injector get injector => Injector.appInstance;
}
