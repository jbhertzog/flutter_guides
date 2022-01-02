// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/data/models/employee_model.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class EmployeeNetworkRequests {
  /// Calls the API via HTTP request to get the Employees
  Future<Either<Failure, List<Employee>>> getEmployees();
}

class EmployeeNetworkRequestsImpl implements EmployeeNetworkRequests {
  @override
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    try {
      var response = await http.get(Uri.parse('http://dummy.restapiexample.com/api/v1/employees'));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        List<Employee> employees = [];
        for (var employee in responseBody['data']) {
          employees.add(EmployeeModel.fromJson(employee));
        }
        return Right(employees);
      } else {
        return Left(ServerFailure());
      }
    } catch (exception, stackTrace) {
      /// This is normally where you would use your logging tool (Firebase, etc.) to log the error.
      /// For now we will simply print it out.
      print("-- START OF ERROR --\n"
          "Exception: $exception\n"
          "Stacktrace: $stackTrace\n"
          "-- END OF ERROR");
      return Left(ServerFailure());
    }
  }
}
