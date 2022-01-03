import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_body/employee_builder.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AllEmployeesScreenBody extends StatelessWidget {
  const AllEmployeesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, employeeState) {
        if (employeeState is RetrievingEmployeesFromServerFailure) {
          /// Show error
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
