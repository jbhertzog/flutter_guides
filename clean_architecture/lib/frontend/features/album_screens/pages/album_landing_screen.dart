import 'package:clean_architecture/frontend/features/album_screens/widgets/album_landing_screen_widgets/album_landing_screen_body.dart';
import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_screen_header.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/core/dependency_injection/injection_container.dart';
import 'package:clean_architecture/logic/presentation/albums/album_bloc.dart';
import 'package:clean_architecture/logic/presentation/albums/album_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumLandingScreen extends StatefulWidget {
  const AlbumLandingScreen({Key? key}) : super(key: key);

  @override
  _AlbumLandingScreenState createState() => _AlbumLandingScreenState();
}

class _AlbumLandingScreenState extends State<AlbumLandingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AlbumBloc _albumBloc;

  @override
  void initState() {
    super.initState();
    _albumBloc = serviceLocator<AlbumBloc>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _albumBloc.add(GetAlbumsFromDeviceStorage()),
    );
  }

  @override
  void dispose() {
    if (serviceLocator.isRegistered<AlbumBloc>(instance: _albumBloc)) {
      serviceLocator.resetLazySingleton<AlbumBloc>(
        instance: _albumBloc,
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (_) => _albumBloc,
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
                  child: AlbumScreenHeader(
                    localeString: 'albums',
                  ),
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
                      child: AlbumLandingScreenBody(),
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
