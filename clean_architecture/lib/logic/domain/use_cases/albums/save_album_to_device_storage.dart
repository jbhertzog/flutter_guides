import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:clean_architecture/logic/domain/repositories/album_repository.dart';
import 'package:dartz/dartz.dart';

class SaleAlbumToDeviceStorage implements UseCase<bool, SaveAlbumToDatabaseParams> {
  final AlbumRepository _albumRepository;

  SaleAlbumToDeviceStorage({required AlbumRepository albumRepository}) : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, bool>> call(SaveAlbumToDatabaseParams params) async {
    var failureOrWasSaved = await _albumRepository.saveAlbumToDeviceStorage(params.album);
    return failureOrWasSaved.fold(
      (failure) => Left(failure),
      (wasSaved) => Right(wasSaved),
    );
  }
}

class SaveAlbumToDatabaseParams {
  final Album album;

  SaveAlbumToDatabaseParams({required this.album});
}
