import 'package:clean_architecture/logic/domain/entities/album.dart';

abstract class AlbumState {
  List<Album> albumsFromServer;
  List<Album> albumsFromLocalStorage;

  AlbumState({
    required this.albumsFromServer,
    required this.albumsFromLocalStorage,
  });
}

class AlbumDefault extends AlbumState {
  AlbumDefault()
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

/// Generic state needed to display changes as discussed in the PDF Guide: [State Management & BLoC]
class AlbumIgnoreState extends AlbumState {
  AlbumIgnoreState(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

//region GET ALBUMS FROM SERVER
class RetrievingAlbumsFromServer extends AlbumState {
  RetrievingAlbumsFromServer(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

/// Contains an optional errorMessage that can be displayed on the frontend
/// In a real life scenario, this error message would be sent from the backend along with the error response.
class RetrievingAlbumsFromServerFailure extends AlbumState {
  String? errorMessage;

  RetrievingAlbumsFromServerFailure(AlbumState state, {this.errorMessage})
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class RetrievingAlbumsFromServerSuccess extends AlbumState {
  RetrievingAlbumsFromServerSuccess(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}
//endregion

//region GET ALBUMS FROM DEVICE STORAGE
class RetrievingAlbumsFromDeviceStorage extends AlbumState {
  RetrievingAlbumsFromDeviceStorage(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class RetrievingAlbumsFromDeviceStorageFailure extends AlbumState {
  RetrievingAlbumsFromDeviceStorageFailure(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class RetrievingAlbumsFromDeviceStorageSuccess extends AlbumState {
  RetrievingAlbumsFromDeviceStorageSuccess(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}
//endregion

//region SAVE ALBUM TO DEVICE STORAGE
class SavingAlbumToDeviceStorage extends AlbumState {
  final Album albumBeingSaved;

  SavingAlbumToDeviceStorage(AlbumState state, this.albumBeingSaved)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class SavingAlbumToDeviceStorageFailure extends AlbumState {
  SavingAlbumToDeviceStorageFailure(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class SavingAlbumToDeviceStorageSuccess extends AlbumState {
  SavingAlbumToDeviceStorageSuccess(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}
//endregion

//region DELETE ALBUM FROM DEVICE STORAGE
class DeletingAlbumFromDeviceStorage extends AlbumState {
  final Album albumBeingDeleted;

  DeletingAlbumFromDeviceStorage(AlbumState state, this.albumBeingDeleted)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class DeletingAlbumFromDeviceStorageFailure extends AlbumState {
  DeletingAlbumFromDeviceStorageFailure(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}

class DeletingAlbumFromDeviceStorageSuccess extends AlbumState {
  DeletingAlbumFromDeviceStorageSuccess(AlbumState state)
      : super(
          albumsFromServer: [],
          albumsFromLocalStorage: [],
        );
}
//endregion
