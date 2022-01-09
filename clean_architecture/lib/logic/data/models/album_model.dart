import 'package:clean_architecture/logic/domain/entities/album.dart';

class AlbumModel extends Album {
  AlbumModel({
    required int id,
    required int userId,
    required String title,
  }) : super(
          id: id,
          userId: userId,
          title: title,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? 'Untitled',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }
}
