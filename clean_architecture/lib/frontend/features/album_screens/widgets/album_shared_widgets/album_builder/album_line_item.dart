import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_details_popup.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:clean_architecture/logic/presentation/albums/album_bloc.dart';
import 'package:clean_architecture/logic/presentation/albums/album_events.dart';
import 'package:clean_architecture/logic/presentation/albums/album_state.dart';
import 'package:collection/collection.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AlbumLineItem extends StatelessWidget {
  final Album album;
  final String albumCoverPath;
  final bool isForLocalStorage;

  const AlbumLineItem({
    Key? key,
    required this.album,
    required this.albumCoverPath,
    required this.isForLocalStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlbumBloc _albumBloc = BlocProvider.of<AlbumBloc>(context);
    AlbumState _albumState = _albumBloc.state;
    final bool isSavedOnDevice =
        isForLocalStorage ? true : _albumState.albumsFromLocalStorage.firstWhereOrNull((loopAlbum) => loopAlbum.id == album.id) != null;
    final bool albumBeingSaved = (_albumState is SavingAlbumToDeviceStorage) && (_albumState.albumBeingSaved.id == album.id);
    final bool albumBeingDeleted = (_albumState is DeletingAlbumFromDeviceStorage) && (_albumState.albumBeingDeleted.id == album.id);
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(
          AlbumDetailsPopup(
            album: album,
            albumCoverPath: albumCoverPath,
          ),
        );
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "${album.id}${album.title}",
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(albumCoverPath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                album.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            right: 8,
            child: GestureDetector(
              onTap: albumBeingSaved || albumBeingDeleted
                  ? null
                  : () {
                      _albumBloc.add(
                        isSavedOnDevice
                            ? DeleteAlbumFromDevice(
                                album: album,
                              )
                            : SaveAlbumToDevice(
                                album: album,
                              ),
                      );
                    },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 42,
                width: 42,
                child: albumBeingSaved || albumBeingDeleted
                    ? const Center(
                        child: SizedBox(
                          height: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulseSync,
                            colors: [AppColors.darkBlue],
                          ),
                        ),
                      )
                    : Center(
                        child: SvgPicture.asset(
                          isSavedOnDevice ? 'assets/icons/Trash_Can_Icon.svg' : 'assets/icons/Download_Icon.svg',
                          color: isSavedOnDevice ? AppColors.red : AppColors.green,
                          height: 25,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
