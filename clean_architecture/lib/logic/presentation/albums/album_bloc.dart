// ignore_for_file: avoid_print

import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/delete_album_from_device_storage.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/retrieve_all_albums_from_device_storage.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/retrieve_all_albums_from_server.dart';
import 'package:clean_architecture/logic/domain/use_cases/albums/save_album_to_device_storage.dart';
import 'package:clean_architecture/logic/presentation/albums/album_events.dart';
import 'package:clean_architecture/logic/presentation/albums/album_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<AlbumEvents, AlbumState> {
  final RetrieveAllAlbumsFromServer _retrieveAllAlbumsFromServer;
  final RetrieveAllAlbumsFromDeviceStorage _retrieveAllAlbumsFromDeviceStorage;
  final SaleAlbumToDeviceStorage _saleAlbumToDeviceStorage;
  final DeleteAlbumFromDeviceStorage _deleteAlbumFromDeviceStorage;

  AlbumBloc({
    required RetrieveAllAlbumsFromServer retrieveAllAlbumsFromServer,
    required RetrieveAllAlbumsFromDeviceStorage retrieveAllAlbumsFromDeviceStorage,
    required SaleAlbumToDeviceStorage saleAlbumToDeviceStorage,
    required DeleteAlbumFromDeviceStorage deleteAlbumFromDeviceStorage,
  })  : _retrieveAllAlbumsFromServer = retrieveAllAlbumsFromServer,
        _retrieveAllAlbumsFromDeviceStorage = retrieveAllAlbumsFromDeviceStorage,
        _saleAlbumToDeviceStorage = saleAlbumToDeviceStorage,
        _deleteAlbumFromDeviceStorage = deleteAlbumFromDeviceStorage,
        super(AlbumDefault());

  //region OVERRIDE BLOC FUNCTIONS
  @override
  void onChange(Change<AlbumState> change) {
    super.onChange(change);
    print('$runtimeType State Change - $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    /// Normally this is where you would use an error logger to report errors
    /// For now we are simply going to print them
    print("_bloc_$runtimeType Error!\nError: $error\nStacktrace: $stackTrace");
  }

  @override
  Future<Function?> close() async {
    /// If you had any stream subscriptions, etc. active, you would close them in this function
    super.close();
  }

  //endregion

  @override
  Stream<AlbumState> mapEventToState(AlbumEvents event) async* {
    if (event is GetAlbumsFromServer) {
      yield RetrievingAlbumsFromServer(state);
      final failureOrAlbums = await _retrieveAllAlbumsFromServer(NoParams());
      yield failureOrAlbums.fold(
        (failure) => RetrievingAlbumsFromServerFailure(state),
        (albums) {
          state.albumsFromServer = albums;
          return RetrievingAlbumsFromServerSuccess(state);
        },
      );
    } else if (event is GetAlbumsFromDeviceStorage) {
      yield RetrievingAlbumsFromDeviceStorage(state);
      final failureOrAlbums = await _retrieveAllAlbumsFromDeviceStorage(NoParams());
      yield failureOrAlbums.fold(
        (failure) => RetrievingAlbumsFromDeviceStorageFailure(state),
        (albums) {
          state.albumsFromLocalStorage = albums;
          return RetrievingAlbumsFromDeviceStorageSuccess(state);
        },
      );
    } else if (event is SaveAlbumToDevice) {
      yield SavingAlbumToDeviceStorage(state, event.album);
      var params = SaveAlbumToDatabaseParams(album: event.album);
      final failureOrSavedAlbum = await _saleAlbumToDeviceStorage(params);
      yield failureOrSavedAlbum.fold(
        (failure) => SavingAlbumToDeviceStorageFailure(state),
        (savedAlbum) {
          state.albumsFromLocalStorage.add(event.album);
          return SavingAlbumToDeviceStorageSuccess(state);
        },
      );
    } else if (event is DeleteAlbumFromDevice) {
      yield DeletingAlbumFromDeviceStorage(state, event.album);
      var params = DeleteAlbumFromDeviceStorageParams(albumId: event.album.id);
      final failureOrDeletedAlbum = await _deleteAlbumFromDeviceStorage(params);
      yield failureOrDeletedAlbum.fold(
        (failure) => DeletingAlbumFromDeviceStorageFailure(state),
        (deletedAlbum) {
          state.albumsFromLocalStorage.removeWhere((album) => album.id == event.album.id);
          return DeletingAlbumFromDeviceStorageSuccess(state);
        },
      );
    }
  }
}
