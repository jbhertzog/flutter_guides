import 'package:clean_architecture/logic/domain/entities/album.dart';

abstract class AlbumStore {
  /// Stores the [Album] which the user selected locally on the device
  Future<bool> saveAlbum(Album album);

  /// Deletes the specified album
  Future<bool> deleteAlbum(String albumId);

  /// Gets all of the stored albums
  /// If none are stored, it will just return an empty list instead of null
  Future<List<Album>> getAllAlbums();

  /// Deletes all the Album related data from the database
  Future<void> clearDatabase();
}
