import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/langauge/app_locale.dart';
import 'package:flutter/material.dart';

class EmployeeName extends StatelessWidget {
  final String employeeName;

  const EmployeeName({Key? key, required this.employeeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            appLocale.translate('name'),
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          employeeName,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
