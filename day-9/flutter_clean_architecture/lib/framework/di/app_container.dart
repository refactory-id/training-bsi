import 'package:flutter_clean_architecture/framework/di/modules/mapper_module.dart';
import 'package:flutter_clean_architecture/framework/di/modules/network_module.dart';
import 'package:flutter_clean_architecture/framework/di/modules/repository_module.dart';
import 'package:flutter_clean_architecture/framework/di/modules/use_case_module.dart';
import 'package:injector/injector.dart';

class AppContainer {
  static void inject() {
    MapperModule.inject(injector);
    NetworkModule.inject(injector);
    UseCaseModule.inject(injector);
    RepositoryModule.inject(injector);
  }

  static Injector get injector => Injector.appInstance;
}
