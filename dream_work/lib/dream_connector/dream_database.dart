import 'dart:async';
import 'dart:convert';
import 'utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'dream_auth.dart';
import 'dream_core.dart';

class DreamDatabase {
  static final DreamDatabase instance = DreamDatabase._internal();

  late DreamCore _dreamCore;

  // streams
  final BehaviorSubject<List<Map<String, dynamic>>?> _databaseStream =
      BehaviorSubject<List<Map<String, dynamic>>?>.seeded(null);
  final BehaviorSubject<bool> _isLoadingStream =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isConnectedStream =
      BehaviorSubject<bool>.seeded(false);

  /// Return a stream contains all the todoitems belong to the user
  get allItem {
    _readFromDatabaseAllItem();
    return _databaseStream;
  }

  /// Return a stream contains the loading status
  get loadingState => _isLoadingStream;

  /// Return a stream contains the connection status
  get connectedState => _isConnectedStream;

  /// Set the dreamCore
  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  /// Read data from database every 10 seconds
  /// and update the stream
  /// This method is called when the app is opened
  Future connect() async {
    if (_isConnectedStream.value == true) return Future.value();
    _readFromDatabaseAllItem();
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        _readFromDatabaseAllItem()
            .then((value) => _isConnectedStream.add(true))
            .catchError((e) {
          _isConnectedStream.add(false);
          timer.cancel();
        });
      },
    );
  }

  // todo
  disconnect() {
    //_databaseStream.close();
  }

  // methods use read from database

  /// Read all the todoitems belong to the user
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
    loadingState.add(true);
    final Uri url = await pathResolver(path: path, dreamCore: _dreamCore);
    final authToken = await DreamAuth.instance.authToekn;
    loadingState.add(false);
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
    loadingState.add(true);
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
    loadingState.add(false);
  }

  // method use to delete one item

  Future<void> deleteAll() async {
    await _deleteFromDatabase(path: Path.all)
        .then((value) => _readFromDatabaseAllItem());
  }

  Future<void> _deleteFromDatabase({
    required Path path,
  }) async {
    loadingState.add(true);
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': authToken,
    };
    final String body = jsonEncode([]);

    if (kDebugMode) {
      print('_delete: ${body.toString().split(":").first}');
    }

    await delete(
            path: path, headers: headers, body: body, dreamCore: _dreamCore)
        .catchError((e) => throw Exception('faild to delete: $e'));
    loadingState.add(false);
  }

  DreamDatabase._internal();

  factory DreamDatabase() {
    return instance;
  }
}
