import 'package:clean_architecture/logic/domain/entities/album.dart';

abstract class AlbumEvents {}

/// These names differ slightly from those of the use case (e.g. SaveAlbumOnDevice vs SaveAlbumToDevice)
/// This is done on purpose, just to make it a bit more clear which is referring to the [AlbumEvent] vs the [UseCase] the event will call.

class GetAlbumsFromServer implements AlbumEvents {}

class GetAlbumsFromDeviceStorage implements AlbumEvents {}

class SaveAlbumToDevice implements AlbumEvents {
  final Album album;

  SaveAlbumToDevice({required this.album});
}

class DeleteAlbumFromDevice implements AlbumEvents {
  final Album album;

  DeleteAlbumFromDevice({required this.album});
}
