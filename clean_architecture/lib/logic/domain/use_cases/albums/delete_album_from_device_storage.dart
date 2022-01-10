import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/repositories/album_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAlbumFromDeviceStorage implements UseCase<bool, DeleteAlbumFromDeviceStorageParams> {
  final AlbumRepository _albumRepository;

  DeleteAlbumFromDeviceStorage({
    required AlbumRepository albumRepository,
  }) : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, bool>> call(DeleteAlbumFromDeviceStorageParams params) async {
    var failureOrWasDeleted = await _albumRepository.deleteAlbumFromDb(params.albumId.toString());
    return failureOrWasDeleted.fold(
      (failure) => Left(failure),
      (wasDeleted) => Right(wasDeleted),
    );
  }
}

class DeleteAlbumFromDeviceStorageParams {
  final int albumId;

  DeleteAlbumFromDeviceStorageParams({required this.albumId});
}
