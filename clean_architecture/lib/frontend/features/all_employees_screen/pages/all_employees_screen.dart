import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_body.dart';
import 'package:clean_architecture/frontend/features/all_employees_screen/widgets/all_employees_screen_header.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/core/dependency_injection/injection_container.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEmployeesScreen extends StatefulWidget {
  const AllEmployeesScreen({Key? key}) : super(key: key);

  @override
  _AllEmployeesScreenState createState() => _AllEmployeesScreenState();
}

class _AllEmployeesScreenState extends State<AllEmployeesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    super.initState();
    _employeeBloc = serviceLocator<EmployeeBloc>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _employeeBloc.add(RetrieveEmployees()),
    );
  }

  @override
  void dispose() {
    if (serviceLocator.isRegistered<EmployeeBloc>(instance: _employeeBloc)) {
      serviceLocator.resetLazySingleton<EmployeeBloc>(
        instance: _employeeBloc,
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (_) => _employeeBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.darkBlue,
          ),
          child: SafeArea(
            top: true,
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: AllEmployeesScreenHeader(),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: AllEmployeesScreenBody(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
