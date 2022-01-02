import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getEmployeesFromServer();
}
