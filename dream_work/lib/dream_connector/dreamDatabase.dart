import 'package:flutter/foundation.dart';
import 'fetcher.dart';
import 'package:rxdart/rxdart.dart';
import 'dreamAuth.dart';
import 'dreamCore.dart';

enum DatabasePath {
  all,
}

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
    _getAllItem();
    return _databaseStream;
  }

  Future<void> _getAllItem() async {
    _databaseStream.add(null);
    final data = await _pathResolver(DatabasePath.all).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
    _databaseStream.add(data);
  }

  /// a path resolver to get the data from the backend
  Future<List<Map<String, dynamic>>?> _pathResolver(
    DatabasePath databasePath,
  ) async {
    late String _path;
    switch (databasePath) {
      case DatabasePath.all:
        _path = '/api/todos';
        break;
    }
    final serverUrl = await _dreamCore.coreState();
    final Uri urlWithPath = Uri.parse(serverUrl.toString() + _path);
    final authToken = await DreamAuth.instance.authToekn;

    if (kDebugMode) {
      print('_pathResolver: $urlWithPath');
    }

    return IndividualFetcher(
      authToken: authToken,
      serverUrl: urlWithPath,
    ).getResult();
  }

  DreamDatabase._internal();

  factory DreamDatabase() {
    return instance;
  }
}
