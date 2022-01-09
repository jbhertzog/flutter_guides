// ignore_for_file: avoid_print

import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/use_cases/employees/retrieve_employee_data_from_server.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_events.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvents, EmployeeState> {
  final RetrieveEmployeeDataFromServer _retrieveEmployeeDataFromServer;

  EmployeeBloc({
    required RetrieveEmployeeDataFromServer retrieveEmployeeDataFromServer,
  })  : _retrieveEmployeeDataFromServer = retrieveEmployeeDataFromServer,
        super(EmployeeDefault());

  //region OVERRIDE BLOC FUNCTIONS
  @override
  void onChange(Change<EmployeeState> change) {
    super.onChange(change);
    print('$runtimeType State Change - $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    /// Normally this is where you would use an error logger to report errors
    /// For now we are simply going to print them
    print("_bloc_$runtimeType Error!\nError: $error\nStacktrace: $stackTrace");
  }

  @override
  Future<Function?> close() async {
    /// If you had any stream subscriptions, etc. active, you would close them in this function
    super.close();
  }

  //endregion

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvents event) async* {
    if (event is RetrieveEmployees) {
      yield RetrievingEmployeesFromServer(state);
      final failureOrEmployees = await _retrieveEmployeeDataFromServer(NoParams());
      yield failureOrEmployees.fold(
        (failure) => RetrievingEmployeesFromServerFailure(state),
        (employees) {
          state.employees = employees;
          return RetrievingEmployeesFromServerSuccess(state);
        },
      );
    }
  }
}
