import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return ListView(
      children: [
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/allEmployeesScreen');
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
                appLocale.translate('employees'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/albumLandingScreen');
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
                appLocale.translate('albums'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
