import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/data/data_sources/server/network_requests/employee_network_requests.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:clean_architecture/logic/domain/repositories/employee_repository.dart';
import 'package:dartz/dartz.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeNetworkRequests _employeeNetworkRequests;

  EmployeeRepositoryImpl({
    required EmployeeNetworkRequests employeeNetworkRequests,
  }) : _employeeNetworkRequests = employeeNetworkRequests;

  @override
  Future<Either<Failure, List<Employee>>> getEmployeesFromServer() async {
    var failureOrEmployees = await _employeeNetworkRequests.getEmployees();
    return failureOrEmployees.fold(
      (failure) => Left(failure),
      (employees) => Right(employees),
    );
  }
}
