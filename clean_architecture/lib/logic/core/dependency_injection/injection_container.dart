import 'package:clean_architecture/logic/data/data_sources/server/network_requests/employee_network_requests.dart';
import 'package:clean_architecture/logic/data/repositories/employee_repository_impl.dart';
import 'package:clean_architecture/logic/domain/repositories/employee_repository.dart';
import 'package:clean_architecture/logic/domain/use_cases/employees/retrieve_employee_data_from_server.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class DependencyInjection {
  Future<void> init() async {
    /// API Calls
    _networkServices();

    /// Repositories
    _repositories();

    /// Use Cases
    _useCases();

    /// BLoC
    _blocs();
  }

  void _networkServices() {
    /// Employee Network Requests
    serviceLocator.registerLazySingleton<EmployeeNetworkRequests>(
      () => EmployeeNetworkRequestsImpl(),
    );
  }

  void _repositories() {
    /// Employees
    serviceLocator.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(
        employeeNetworkRequests: serviceLocator(),
      ),
    );
  }

  void _useCases() {
    /// Retrieve Employee Data from Server
    serviceLocator.registerLazySingleton(
      () => RetrieveEmployeeDataFromServer(
        employeeRepository: serviceLocator(),
      ),
    );
  }

  void _blocs() {
    /// Employee BLoC
    serviceLocator.registerLazySingleton(
      () => EmployeeBloc(
        retrieveEmployeeDataFromServer: serviceLocator(),
      ),
    );
  }
}
