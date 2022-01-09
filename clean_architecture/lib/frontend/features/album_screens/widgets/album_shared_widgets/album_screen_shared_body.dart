import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_builder/album_builder.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:clean_architecture/logic/presentation/albums/album_bloc.dart';
import 'package:clean_architecture/logic/presentation/albums/album_state.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AlbumScreenSharedBody extends StatelessWidget {
  final bool isForLocalStorage;

  const AlbumScreenSharedBody({Key? key, required this.isForLocalStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return BlocConsumer<AlbumBloc, AlbumState>(
      listener: (context, albumState) {
        if (albumState is RetrievingAlbumsFromServerFailure || albumState is RetrievingAlbumsFromDeviceStorageFailure) {
          ElegantNotification.error(
            title: appLocale.translate('error'),
            description: appLocale.translate('data_retrieval_failure'),
            toastDuration: 2000,
          ).show(context);
        }
      },
      buildWhen: (previous, current) {
        if (current is AlbumIgnoreState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is RetrievingAlbumsFromServer || state is RetrievingAlbumsFromDeviceStorage) {
          return const Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
                colors: [AppColors.darkBlue],
              ),
            ),
          );
        }
        return Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AlbumBuilder(
                  albums: isForLocalStorage ? state.albumsFromLocalStorage : state.albumsFromServer,
                  isForLocalStorage: isForLocalStorage,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
