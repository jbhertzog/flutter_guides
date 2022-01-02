import 'package:clean_architecture/logic/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    required int id,
    required String employeeName,
    required double employeeSalary,
    required int employeeAge,
  }) : super(
          id: id,
          employeeName: employeeName,
          employeeSalary: employeeSalary,
          employeeAge: employeeAge,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    /// Note: The response from the API has the fields using an underscore to separate names in the field names
    /// I prefer to use camelCase, so I have implemented the properties on the [Employee] as such.
    return EmployeeModel(
      id: json['id'] ?? 0,
      employeeName: json['employee_name'] ?? '',
      employeeSalary: json['employee_salary'] ?? 0.0,
      employeeAge: json['employee_age'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    /// As mentioned above, just take care in the difference on how the field names are used.
    /// Saving them in camel case form will cause them to not be found if you were to store the model
    /// in JSON format in some offline database such as Hive, and then try to read it later again.
    return {
      'id': id,
      'employee_name': employeeName,
      'employee_salary': employeeSalary,
      'employee_age': employeeAge,
    };
  }
}
