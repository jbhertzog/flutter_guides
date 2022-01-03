import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/specific_employee/employee_details/employee_age.dart';
import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/specific_employee/employee_details/employee_name.dart';
import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/specific_employee/employee_details/employee_salary.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:clean_architecture/logic/langauge/app_locale.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class SpecificEmployeeDetails extends StatelessWidget {
  final Employee employee;

  const SpecificEmployeeDetails({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return DismissiblePage(
      onDismiss: () => Navigator.of(context).pop(),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      direction: DismissDirection.vertical,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocale.translate('employee'),
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 64),
              EmployeeName(
                employeeName: employee.employeeName,
              ),
              const SizedBox(height: 32),
              EmployeeAge(
                employeeAge: employee.employeeAge,
              ),
              const SizedBox(height: 32),
              EmployeeSalary(
                employeeSalary: employee.employeeSalary,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
