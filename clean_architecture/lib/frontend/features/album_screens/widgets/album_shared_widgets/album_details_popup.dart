import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class AlbumDetailsPopup extends StatelessWidget {
  final Album album;
  final String albumCoverPath;

  const AlbumDetailsPopup({
    Key? key,
    required this.album,
    required this.albumCoverPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismiss: () => Navigator.of(context).pop(),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      backgroundColor: AppColors.darkBlue,
      startingOpacity: 0.8,
      direction: DismissDirection.vertical,
      child: Hero(
        tag: "${album.id}${album.title}",
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  album.title,
                  style: const TextStyle(color: AppColors.darkBlue),
                ),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(albumCoverPath),
                fit: BoxFit.values[4],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
