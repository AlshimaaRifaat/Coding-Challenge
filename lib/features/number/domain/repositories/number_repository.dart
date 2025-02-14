import 'package:challenge/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class NumberRepository {
  Future<Either<Failure, int>> getRandomNumber();
}
