// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture/logic/core/error/exceptions.dart';
import 'package:clean_architecture/logic/data/data_sources/databases/interfaces/album_store.dart';
import 'package:clean_architecture/logic/data/models/album_model.dart';
import 'package:clean_architecture/logic/domain/entities/album.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class SembastAlbumStore implements AlbumStore {
  final String _dbPath;

  SembastAlbumStore({required String path}) : _dbPath = path;

  Database? _albumDb;
  StoreRef? _albumStore;

  /// This function will always only be called by [getAllAlbums] when the AlbumBloc is first created.
  /// This is to ensure that in our AlbumState, we have a list of all the albums, so that a user can not save an album
  /// locally more than once.
  Future<void> _openStore() async {
    try {
      if (_albumDb == null && _albumStore == null) {
        String dbPath = '$_dbPath/SembastAlbumStore.db';
        final sqfFactory = getDatabaseFactorySqflite(sqflite.databaseFactory);

        _albumDb = await sqfFactory.openDatabase(dbPath, version: 1, mode: DatabaseMode.neverFails);
        _albumStore = stringMapStoreFactory.store('OrderingStore');
        print("-- AlbumStore successfully created --");
      } else {
        print("-- AlbumStore already created --");
      }
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      _albumDb = null;
    }
  }

  Future<void> _closeDb() async {
    try {
      if (_albumDb != null) {
        await _albumDb!.close();
        _albumDb = null;
        _albumStore = null;
      }
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      throw CacheException();
    }
  }

  @override
  Future<bool> saveAlbum(Album album) async {
    try {
      if (_albumDb != null) {
        await _albumDb!.transaction((txn) async {
          await _albumStore!.record(album.id.toString()).put(txn, jsonEncode(album.toJson()));
        });
      }
      return true;
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      throw CacheException();
    }
  }

  @override
  Future<bool> deleteAlbum(String id) async {
    try {
      if (_albumDb != null && _albumStore != null) {
        var orderingItemRecord = _albumStore!.record(id);
        await orderingItemRecord.delete(_albumDb!);
      }
      return true;
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      throw CacheException();
    }
  }

  @override
  Future<List<Album>> getAllAlbums() async {
    try {
      await _openStore();
      List<Album> _albums = [];
      if (_albumDb != null) {
        List<RecordSnapshot> _albumRecords = await _albumStore!.find(_albumDb!);
        for (RecordSnapshot _albumRecord in _albumRecords) {
          _albums.add(AlbumModel.fromJson(jsonDecode(_albumRecord.value)));
        }
      }
      return _albums;
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      throw CacheException();
    }
  }

  @override
  Future<void> clearDatabase() async {
    try {
      if (_albumDb != null) {
        await _albumStore!.drop(_albumDb!);
      }
    } catch (ex, st) {
      print('SembastAlbumStore exception!\nException: $ex\nStackTrace: $st');
      throw CacheException();
    }
  }
}
