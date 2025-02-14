import 'package:challenge/core/services/local_storage_services.dart';

abstract class LocalDataSource {
  Future<DateTime?> getLastPrimeTime();
  Future<void> saveLastPrimeTime(DateTime time);
}

class LocalDataSourceImpl implements LocalDataSource {
  final LocalStorageService service;

  LocalDataSourceImpl(this.service);

  @override
  Future<DateTime?> getLastPrimeTime() => service.getLastPrimeTime();

  @override
  Future<void> saveLastPrimeTime(DateTime time) =>
      service.saveLastPrimeTime(time);
}
