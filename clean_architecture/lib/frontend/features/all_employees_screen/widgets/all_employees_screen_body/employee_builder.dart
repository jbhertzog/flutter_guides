import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_body/employee_list_item.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/employee.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              SvgPicture.asset(
                'assets/icons/No_Items_Icon.svg',
                color: AppColors.darkBlue,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Text(
                  appLocale.translate('no_results'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkBlue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<EmployeeBloc>(context).add(RetrieveEmployees());
                },
                child: Container(
                  height: 62,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.darkBlue,
                  ),
                  child: Center(
                    child: Text(
                      appLocale.translate('retry'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
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
