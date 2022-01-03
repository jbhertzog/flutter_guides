import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';

class EmployeeAge extends StatelessWidget {
  final int employeeAge;

  const EmployeeAge({Key? key, required this.employeeAge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            appLocale.translate('age'),
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '$employeeAge',
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
