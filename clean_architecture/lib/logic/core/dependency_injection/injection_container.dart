import 'dart:io';

import 'package:clean_architecture/logic/data/data_sources/databases/interfaces/album_store.dart';
import 'package:clean_architecture/logic/data/data_sources/databases/sembast/sembast_album_store.dart';
import 'package:clean_architecture/logic/data/data_sources/server/network_requests/albums/album_network_requests.dart';
import 'package:clean_architecture/logic/data/data_sources/server/network_requests/employees/employee_network_requests.dart';
import 'package:clean_architecture/logic/data/repositories/album_repository_impl.dart';
import 'package:clean_architecture/logic/data/repositories/employee_repository_impl.dart';
import 'package:clean_architecture/logic/domain/repositories/album_repository.dart';
import 'package:clean_architecture/logic/domain/repositories/employee_repository.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/delete_album_from_device_storage.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/retrieve_all_albums_from_device_storage.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/retrieve_all_albums_from_server.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/save_album_to_device_storage.dart';
import 'package:clean_architecture/logic/domain/use_cases/employees/retrieve_employee_data_from_server.dart';
import 'package:clean_architecture/logic/presentation/albums/album_bloc.dart';
import 'package:clean_architecture/logic/presentation/employee/employee_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

class DependencyInjection {
  Future<void> init() async {
    /// Databases
    ///
    /// The reason this is marked as await, is because in a real life scenario, you might have different flows when an app is launched
    /// depending on if a user is signed in or not (i.e. navigate to either the landing page of your app, or the sign in screen, etc.)
    /// This means that the databases must be open and available for use before you can go further.
    await _databases();

    /// API Calls
    _networkServices();

    /// Repositories
    _repositories();

    /// Use Cases
    _useCases();

    /// BLoC
    _blocs();
  }

  Future<void> _databases() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocDir.path}/databases/';

    //Album Database using Sembast
    serviceLocator.registerLazySingleton<AlbumStore>(
      () => SembastAlbumStore(path: dbPath),
    );
  }

  void _networkServices() {
    /// Employee Network Requests
    serviceLocator.registerLazySingleton<EmployeeNetworkRequests>(
      () => EmployeeNetworkRequestsImpl(),
    );

    /// Album Network Requests
    serviceLocator.registerLazySingleton<AlbumNetworkRequests>(
      () => AlbumNetworkRequestsImpl(),
    );
  }

  void _repositories() {
    /// Employees
    serviceLocator.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(
        employeeNetworkRequests: serviceLocator(),
      ),
    );

    /// Albums
    serviceLocator.registerLazySingleton<AlbumRepository>(
      () => AlbumRepositoryImpl(
        albumNetworkRequests: serviceLocator(),
        albumStore: serviceLocator(),
      ),
    );
  }

  void _useCases() {
    //region EMPLOYEES
    /// Retrieve Employee Data from Server
    serviceLocator.registerLazySingleton(
      () => RetrieveEmployeeDataFromServer(
        employeeRepository: serviceLocator(),
      ),
    );
    //endregion

    //region ALBUMS
    /// Retrieve Albums from Server
    serviceLocator.registerLazySingleton(
      () => RetrieveAllAlbumsFromServer(
        albumRepository: serviceLocator(),
      ),
    );

    /// Retrieve Albums from Device Storage
    serviceLocator.registerLazySingleton(
      () => RetrieveAllAlbumsFromDeviceStorage(
        albumRepository: serviceLocator(),
      ),
    );

    /// Save Album to Device Storage
    serviceLocator.registerLazySingleton(
      () => SaleAlbumToDeviceStorage(
        albumRepository: serviceLocator(),
      ),
    );

    /// Delete Album from Device Storage
    serviceLocator.registerLazySingleton(
      () => DeleteAlbumFromDeviceStorage(
        albumRepository: serviceLocator(),
      ),
    );
    //endregion
  }

  void _blocs() {
    /// Employee BLoC
    serviceLocator.registerLazySingleton(
      () => EmployeeBloc(
        retrieveEmployeeDataFromServer: serviceLocator(),
      ),
    );

    /// Album BLoC
    serviceLocator.registerLazySingleton(
      () => AlbumBloc(
        retrieveAllAlbumsFromServer: serviceLocator(),
        retrieveAllAlbumsFromDeviceStorage: serviceLocator(),
        saleAlbumToDeviceStorage: serviceLocator(),
        deleteAlbumFromDeviceStorage: serviceLocator(),
      ),
    );
  }
}
