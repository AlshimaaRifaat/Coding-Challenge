import 'package:challenge/core/services/local_storage_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/utils/network_info.dart';
import 'features/clock/presentation/bloc/clock_bloc.dart';
import 'features/number/data/datasources/local_data_source.dart';
import 'features/number/data/datasources/remote_data_source.dart';
import 'features/number/data/repositories/number_repository_impl.dart';
import 'features/number/domain/repositories/number_repository.dart';
import 'features/number/domain/usecases/get_random_number.dart';
import 'features/number/presentation/bloc/number_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerSingleton<LocalStorageService>(LocalStorageService());
  getIt.registerSingleton<Connectivity>(Connectivity());

  // Data Sources
  getIt.registerSingleton<RemoteDataSource>(
      RemoteDataSourceImpl(client: http.Client()));
  getIt.registerSingleton<LocalDataSource>(
      LocalDataSourceImpl(getIt<LocalStorageService>()));

  // Repository
  getIt.registerSingleton<NumberRepository>(
    NumberRepositoryImpl(
      remoteDataSource: getIt<RemoteDataSource>(),
      localDataSource: getIt<LocalDataSource>(),
      networkInfo: NetworkInfoImpl(getIt<Connectivity>()),
    ),
  );

  // Use Cases
  getIt.registerSingleton(GetRandomNumber(getIt<NumberRepository>()));

  // BLoCs
  getIt.registerFactory(() => ClockBloc());
  getIt.registerFactory(() => NumberBloc(
        getRandomNumber: getIt<GetRandomNumber>(),
        localStorage: getIt<LocalStorageService>(),
      ));
}
