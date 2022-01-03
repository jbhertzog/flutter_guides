import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_body/employee_builder.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_state.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AllEmployeesScreenBody extends StatelessWidget {
  const AllEmployeesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, employeeState) {
        if (employeeState is RetrievingEmployeesFromServerFailure) {
          ElegantNotification.error(
            title: appLocale.translate('error'),
            description: appLocale.translate('data_retrieval_failure'),
            toastDuration: 2000,
          ).show(context);
        }
      },
      buildWhen: (previous, current) {
        if (current is EmployeeIgnoreState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is RetrievingEmployeesFromServer) {
          return const Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
                colors: [AppColors.darkBlue],
              ),
            ),
          );
        }
        return EmployeeBuilder(
          employees: state.employees,
        );
      },
    );
  }
}
