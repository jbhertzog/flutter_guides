import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_body/employee_list_item.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeBuilder extends StatelessWidget {
  final List<Employee> employees;

  const EmployeeBuilder({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return employees.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SvgPicture.asset(
                  'assets/icons/No_Items_Icon.svg',
                  color: AppColors.darkBlue,
                ),
              ),
              Text(
                appLocale.translate('no_results'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          )
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 16 : 0),
                  child: EmployeeListItem(
                    employee: employees[index],
                  ),
                );
              },
            ),
          );
  }
}
