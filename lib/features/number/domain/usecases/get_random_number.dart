import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/number_repository.dart';

class GetRandomNumber {
  final NumberRepository repository;

  GetRandomNumber(this.repository);

  Future<Either<Failure, int>> call() async {
    return await repository.getRandomNumber();
  }
}
