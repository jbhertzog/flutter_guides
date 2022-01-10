// ignore_for_file: avoid_print

import 'dart:async';

import 'package:clean_architecture/frontend/navigation/route_generator.dart';
import 'package:clean_architecture/logic/core/dependency_injection/injection_container.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Init Dependency Injection
  await DependencyInjection().init();

  runZonedGuarded<Future<void>>(() async {
    runApp(const CleanArchitectureApplication());
  }, _logDebuggingError);
}

void _logDebuggingError(Object error, StackTrace? stack) {
  /// Normally this is where you would use an error logger to report errors
  /// For now we are simply going to print them
  print("Flutter Error!\nError: $error\nStacktrace: $stack");
}

class CleanArchitectureApplication extends StatelessWidget {
  const CleanArchitectureApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture',
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: const [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
