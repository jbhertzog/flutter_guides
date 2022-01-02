import 'package:clean_architecture/logic/domain/entities/employee.dart';

abstract class EmployeeEvents {}

class RetrieveEmployees implements EmployeeEvents {}

class SearchForEmployees implements EmployeeEvents {
  final String searchText;

  SearchForEmployees({required this.searchText});
}

class SetSpecificEmployee implements EmployeeEvents {
  final Employee selectedEmployee;

  SetSpecificEmployee({required this.selectedEmployee});
}
