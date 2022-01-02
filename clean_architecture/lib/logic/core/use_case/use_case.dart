import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure?, Type>> call(Params params);
}

class NoParams {}
