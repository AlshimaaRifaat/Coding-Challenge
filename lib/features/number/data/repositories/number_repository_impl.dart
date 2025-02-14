import 'package:challenge/core/errors/exceptions.dart';
import 'package:challenge/core/errors/failures.dart';
import 'package:challenge/core/utils/network_info.dart';
import 'package:challenge/features/number/data/datasources/local_data_source.dart';
import 'package:challenge/features/number/data/datasources/remote_data_source.dart';
import 'package:challenge/features/number/domain/repositories/number_repository.dart';
import 'package:dartz/dartz.dart';

class NumberRepositoryImpl implements NumberRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> getRandomNumber() async {
    if (await networkInfo.isConnected) {
      try {
        final number = await remoteDataSource.getRandomNumber();
        return Right(number);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
