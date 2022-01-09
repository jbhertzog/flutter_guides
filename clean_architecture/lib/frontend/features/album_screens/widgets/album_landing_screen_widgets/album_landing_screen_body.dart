import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';

class AlbumLandingScreenBody extends StatelessWidget {
  const AlbumLandingScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return ListView(
      children: [
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/albumServerScreen');
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
                appLocale.translate('web'),
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
            Navigator.pushNamed(context, '/albumDeviceStorageScreen');
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
                appLocale.translate('downloaded'),
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
