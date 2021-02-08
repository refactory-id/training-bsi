import 'package:with_dependency_injection/di/module/network_module.dart';
import 'package:with_dependency_injection/di/module/presenter_module.dart';
import 'package:with_dependency_injection/di/module/repository_module.dart';
import 'package:injector/injector.dart';

class AppComponent {
  static void init() {
    NetworkModule.init(injector);
    RepositoryModule.init(injector);
    PresenterModule.init(injector);
  }

  static Injector get injector => Injector.appInstance;
}
