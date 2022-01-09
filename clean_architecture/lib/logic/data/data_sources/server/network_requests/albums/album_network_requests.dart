// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:clean_architecture/logic/core/error/failures.dart';
import 'package:clean_architecture/logic/data/models/album_model.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class AlbumNetworkRequests {
  /// Calls the API via HTTP request to get the Albums
  Future<Either<Failure, List<Album>>> getAlbums();
}

class AlbumNetworkRequestsImpl implements AlbumNetworkRequests {
  @override
  Future<Either<Failure, List<Album>>> getAlbums() async {
    try {
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        List<Album> _albums = [];
        for (var _album in responseBody) {
          _albums.add(AlbumModel.fromJson(_album));
        }
        return Right(_albums);
      } else {
        return Left(ServerFailure());
      }
    } catch (exception, stackTrace) {
      /// This is normally where you would use your logging tool (Firebase, etc.) to log the error.
      /// For now we will simply print it out.
      print("-- START OF ERROR --\n"
          "Exception: $exception\n"
          "Stacktrace: $stackTrace\n"
          "-- END OF ERROR");
      return Left(ServerFailure());
    }
  }
}
