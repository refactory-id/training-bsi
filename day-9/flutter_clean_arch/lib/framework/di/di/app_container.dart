import 'package:flutter_clean_arch/framework/di/di/modules/controller_module.dart';
import 'package:flutter_clean_arch/framework/di/di/modules/mapper_module.dart';
import 'package:flutter_clean_arch/framework/di/di/modules/network_module.dart';
import 'package:flutter_clean_arch/framework/di/di/modules/presenter_module.dart';
import 'package:flutter_clean_arch/framework/di/di/modules/repository_module.dart';
import 'package:flutter_clean_arch/framework/di/di/modules/use_case_module.dart';
import 'package:injector/injector.dart';

class AppContainer {
  static void inject() {
    MapperModule.inject(injector);
    NetworkModule.inject(injector);
    UseCaseModule.inject(injector);
    PresenterModule.inject(injector);
    ControllerModule.inject(injector);
    RepositoryModule.inject(injector);
  }

  static Injector get injector => Injector.appInstance;
}
