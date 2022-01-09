import 'package:clean_architecture/frontend/app_constants.dart';
import 'package:clean_architecture/frontend/features/album_screens/widgets/album_shared_widgets/album_builder/album_line_item.dart';
import 'package:clean_architecture/frontend/features/styling/app_colors.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:clean_architecture/logic/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlbumBuilder extends StatelessWidget {
  final List<Album> albums;
  final bool isForLocalStorage;

  const AlbumBuilder({
    Key? key,
    required this.albums,
    required this.isForLocalStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocale.of(context)!;
    return albums.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/No_Items_Icon.svg',
                color: AppColors.darkBlue,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  appLocale.translate('no_results'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkBlue,
                  ),
                ),
              ),
            ],
          )
        : MediaQuery.removePadding(
            context: context,
            removeTop: false,
            child: Scrollbar(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                itemCount: albums.length,
                itemBuilder: (BuildContext context, index) {
                  return AlbumLineItem(
                    album: albums[index],
                    albumCoverPath: AppConstants.albumCoverArt[index % 9],
                    isForLocalStorage: isForLocalStorage,
                  );
                },
              ),
            ),
          );
  }
}
