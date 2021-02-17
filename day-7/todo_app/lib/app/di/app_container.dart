import 'package:injector/injector.dart';
import 'package:todo_app/app/di/modules/mapper_module.dart';
import 'package:todo_app/app/di/modules/network_module.dart';

class AppContainer {
  static void inject() {
    NetworkModule.inject(injector);
    MapperModule.inject(injector);
  }

  static Injector get injector => Injector.appInstance;
}
