import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:dartz/dartz.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>> getAlbumsFromServer();

  Future<Either<Failure, bool>> saveAlbumToDeviceStorage(Album album);

  Future<Either<Failure, bool>> deleteOrderingItemFromDb(String id);

  Future<Either<Failure, List<Album>>> getAlbumsFromDeviceStorage();

  Future<void> clearDatabase();
}
