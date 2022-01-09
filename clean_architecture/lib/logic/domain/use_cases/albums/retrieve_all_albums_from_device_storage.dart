import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/core/use_case/use_case.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:clean_architecture/logic/domain/repositories/album_repository.dart';
import 'package:dartz/dartz.dart';

class RetrieveAllAlbumsFromDeviceStorage implements UseCase<List<Album>, NoParams> {
  final AlbumRepository _albumRepository;

  RetrieveAllAlbumsFromDeviceStorage({
    required AlbumRepository albumRepository,
  }) : _albumRepository = albumRepository;

  @override
  Future<Either<Failure, List<Album>>> call(NoParams params) async {
    var failureOrAlbums = await _albumRepository.getAlbumsFromDeviceStorage();
    return failureOrAlbums.fold(
      (failure) => Left(failure),
      (albums) => Right(albums),
    );
  }
}
