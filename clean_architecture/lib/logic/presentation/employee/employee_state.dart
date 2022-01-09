import 'package:clean_architecture/logic/domain/entities/employee.dart';

abstract class EmployeeState {
  List<Employee> employees;

  EmployeeState({required this.employees});
}

class EmployeeDefault extends EmployeeState {
  EmployeeDefault() : super(employees: []);
}

/// Generic state needed to display changes as discussed in the PDF Guide: [State Management & BLoC]
class EmployeeIgnoreState extends EmployeeState {
  EmployeeIgnoreState(EmployeeState state) : super(employees: state.employees);
}

//region GET EMPLOYEES FROM SERVER
/// State to yield while the API call to retrieve the Employees is being made
class RetrievingEmployeesFromServer extends EmployeeState {
  RetrievingEmployeesFromServer(EmployeeState state) : super(employees: state.employees);
}

/// State to yield if the API call failed
///
/// Contains an optional errorMessage that can be displayed on the frontend
class RetrievingEmployeesFromServerFailure extends EmployeeState {
  String? errorMessage;

  RetrievingEmployeesFromServerFailure(EmployeeState state, {this.errorMessage}) : super(employees: state.employees);
}

/// State to yield if the API call succeeded
class RetrievingEmployeesFromServerSuccess extends EmployeeState {
  RetrievingEmployeesFromServerSuccess(EmployeeState state) : super(employees: state.employees);
}
//endregion
