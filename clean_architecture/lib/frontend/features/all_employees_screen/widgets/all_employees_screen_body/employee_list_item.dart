import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/specific_employee/specific_employee_details.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:dismissible_page/src/dismissible_extensions.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(SpecificEmployeeDetails(employee: employee));
      },
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.darkBlue,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  employee.employeeName,
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.darkBlue,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
