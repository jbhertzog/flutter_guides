import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_screen_header.dart';
import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_screen_shared_body.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/core/dependency_injection/injection_container.dart';
import 'package:clean_architecture/logic/presentation/albums/album_bloc.dart';
import 'package:clean_architecture/logic/presentation/albums/album_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumServerScreen extends StatefulWidget {
  const AlbumServerScreen({Key? key}) : super(key: key);

  @override
  _AlbumServerScreenState createState() => _AlbumServerScreenState();
}

class _AlbumServerScreenState extends State<AlbumServerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AlbumBloc _albumBloc;

  @override
  void initState() {
    super.initState();
    _albumBloc = serviceLocator<AlbumBloc>();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _albumBloc.add(GetAlbumsFromServer()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _albumBloc,
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
                    localeString: 'web',
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
                      child: AlbumScreenSharedBody(
                        isForLocalStorage: false,
                      ),
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
