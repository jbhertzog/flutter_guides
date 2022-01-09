import 'package:clean_architecture/frontend/features/album_screens/pages/album_device_storage_screen.dart';
import 'package:clean_architecture/frontend/features/album_screens/pages/album_landing_screen.dart';
import 'package:clean_architecture/frontend/features/album_screens/pages/album_server_screen.dart';
import 'package:clean_architecture/frontend/features/all_employees_screen/pages/all_employees_screen.dart';
import 'package:clean_architecture/frontend/features/home_screen/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: "HomeScreen"),
        );
      case '/allEmployeesScreen':
        return CupertinoPageRoute(
          builder: (_) => const AllEmployeesScreen(),
          settings: const RouteSettings(name: "AllEmployeesScreen"),
        );
      case '/albumLandingScreen':
        return CupertinoPageRoute(
          builder: (_) => const AlbumLandingScreen(),
          settings: const RouteSettings(name: "AlbumLandingScreen"),
        );
      case '/albumServerScreen':
        return CupertinoPageRoute(
          builder: (_) => const AlbumServerScreen(),
          settings: const RouteSettings(name: "AlbumServerScreen"),
        );
      case '/albumDeviceStorageScreen':
        return CupertinoPageRoute(
          builder: (_) => const AlbumDeviceStorageScreen(),
          settings: const RouteSettings(name: "AlbumDeviceStorageScreen"),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Route Error'),
        ),
        body: const Center(
          child: Text("This path doesn't exist, please check the 'RouteGenerator' class for available routes."),
        ),
      );
    });
  }
}
