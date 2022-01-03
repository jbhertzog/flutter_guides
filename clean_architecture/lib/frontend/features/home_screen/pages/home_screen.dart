import 'package:clean_architecture/frontend/features/home_screen/widgets/home_screen_body.dart';
import 'package:clean_architecture/frontend/features/home_screen/widgets/home_screen_header.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: HomeScreenHeader(),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: HomeScreenBody(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
