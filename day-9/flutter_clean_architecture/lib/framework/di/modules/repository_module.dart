import 'package:flutter_clean_architecture/data/persistences/repositories/raja_ongkir_repository.dart';
import 'package:flutter_clean_architecture/domain/persistences/repositories/contracts/raja_ongkir_repository.dart';
import 'package:injector/injector.dart';

class RepositoryModule {
  static void inject(Injector injector) {
    injector.registerSingleton<RajaOngkirRepository>(() =>
        RajaOngkirRepositoryImpl(
            injector.get(), injector.get(), injector.get(), injector.get()));
  }
}
