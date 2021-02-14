import 'package:flutter_clean_architecture/data/repositories/raja_ongkir_repository.dart';
import 'package:flutter_clean_architecture/usecase/repositories/raja_ongkir_repository.dart';
import 'package:injector/injector.dart';

class RepositoryModule {
  static void inject(Injector injector) {
    injector.registerSingleton<RajaOngkirRepository>(() =>
        RajaOngkirRepositoryImpl(
            injector.get(), injector.get(), injector.get(), injector.get()));
  }
}
