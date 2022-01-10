import 'package:clean_architecture/logic/core/error/exceptions.dart';
import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/data/data_sources/databases/interfaces/album_store.dart';
import 'package:clean_architecture/logic/data/data_sources/server/network_requests/albums/album_network_requests.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:clean_architecture/logic/domain/repositories/album_repository.dart';
import 'package:dartz/dartz.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumNetworkRequests _albumNetworkRequests;
  final AlbumStore _albumStore;

  AlbumRepositoryImpl({
    required AlbumNetworkRequests albumNetworkRequests,
    required AlbumStore albumStore,
  })  : _albumNetworkRequests = albumNetworkRequests,
        _albumStore = albumStore;

  @override
  Future<Either<Failure, List<Album>>> getAlbumsFromServer() async {
    var failureOrAlbums = await _albumNetworkRequests.getAlbums();
    return failureOrAlbums.fold(
      (failure) => Left(failure),
      (albums) => Right(albums),
    );
  }

  @override
  Future<Either<Failure, bool>> saveAlbumToDeviceStorage(Album album) async {
    try {
      var wasSaved = await _albumStore.saveAlbum(album);
      return Right(wasSaved);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAlbumFromDb(String id) async {
    try {
      var wasDeleted = await _albumStore.deleteAlbum(id);
      return Right(wasDeleted);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Album>>> getAlbumsFromDeviceStorage() async {
    try {
      return Right(await _albumStore.getAllAlbums());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> clearDatabase() async {
    try {
      await _albumStore.clearDatabase();
    } on CacheException {
      throw CacheException();
    }
  }
}
