import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return Text(
      appLocale.translate('clean_architecture'),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
