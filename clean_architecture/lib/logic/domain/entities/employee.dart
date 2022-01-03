abstract class Employee {
  final int id;
  final String employeeName;
  final int employeeSalary;
  final int employeeAge;

  /// There is another field from the response, namely [profile_image] but I have omitted it, as it is always empty
  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
  });

  Map<String, dynamic> toJson();
}
