import 'dart:convert';

import 'utils.dart';

import 'package:flutter/foundation.dart';
import 'fetcher.dart';
import 'package:rxdart/rxdart.dart';
import 'dreamAuth.dart';
import 'dreamCore.dart';

class DreamDatabase {
  late DreamCore _dreamCore;

  static final DreamDatabase instance = DreamDatabase._internal();

  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  final BehaviorSubject<List<Map<String, dynamic>>?> _databaseStream =
      BehaviorSubject<List<Map<String, dynamic>>?>.seeded(null);

  /// Return a stream contains all the todoitems belong to the user
  get allItem {
    _readFromDatabaseAllItem();
    return _databaseStream;
  }

  // methods use read from database

  Future<void> _readFromDatabaseAllItem() async {
    final List<Map<String, dynamic>>? data =
        await _readFromDatabase(Path.all).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    _databaseStream.add(data);
  }

  Future<List<Map<String, dynamic>>?> _readFromDatabase(
    Path path,
  ) async {
    final Uri url = await pathResolver(path: path, dreamCore: _dreamCore);
    final authToken = await DreamAuth.instance.authToekn;

    return IndividualFetcher(
      authToken: authToken,
      serverUrl: url,
    ).getResult();
  }

  // methods use to write to database

  Future<void> writeOne(Map<String, dynamic> item) async {
    await _writeToDatabase(path: Path.all, items: [item])
        .then((value) => _readFromDatabaseAllItem());
  }

  Future<void> writeAll(List<Map<String, dynamic>> items) async {
    await _writeToDatabase(path: Path.all, items: items)
        .then((value) => _readFromDatabaseAllItem());
  }

  Future<void> _writeToDatabase({
    required Path path,
    required List<Map<String, dynamic>> items,
  }) async {
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': authToken,
    };
    final String body = jsonEncode(items);

    if (kDebugMode) {
      print('_writeToDatabase: ${body.toString().split(":").first}');
    }

    await post(path: path, headers: headers, body: body, dreamCore: _dreamCore)
        .catchError((e) => throw Exception('faild to write to database: $e'));
  }

  // method use to delete one item

  DreamDatabase._internal();

  factory DreamDatabase() {
    return instance;
  }
}
