import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:clean_architecture/logic/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class RetrieveEmployeeDataFromServer implements UseCase<List<Employee>, NoParams> {
  final EmployeeRepository _employeeRepository;

  RetrieveEmployeeDataFromServer({
    required EmployeeRepository employeeRepository,
  }) : _employeeRepository = employeeRepository;

  @override
  Future<Either<Failure, List<Employee>>> call(NoParams noParams) async {
    var failureOrEmployees = await _employeeRepository.getEmployeesFromServer();
    return failureOrEmployees.fold(
      (failure) => Left(failure),
      (employees) => Right(employees),
    );
  }
}
