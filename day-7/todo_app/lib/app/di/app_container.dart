import 'package:injector/injector.dart';
import 'package:todo_app/app/di/modules/cubit_module.dart';
import 'package:todo_app/app/di/modules/mapper_module.dart';
import 'package:todo_app/app/di/modules/network_module.dart';
import 'package:todo_app/app/di/modules/repository_module.dart';
import 'package:todo_app/app/di/modules/use_case_module.dart';

class AppContainer {
  static void inject() {
    NetworkModule.inject(injector);
    MapperModule.inject(injector);
    RepositoryModule.inject(injector);
    UseCaseModule.inject(injector);
    CubitModule.inject(injector);
  }

  static Injector get injector => Injector.appInstance;
}
