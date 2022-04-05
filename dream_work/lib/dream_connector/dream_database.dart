import 'package:rxdart/rxdart.dart';
import 'dream_connector.dart';
import 'utils/utils.dart';
import 'dart:async';
import 'dart:convert';

class DreamDatabase {
  // singleton
  static final DreamDatabase instance = DreamDatabase._internal();
  DreamDatabase._internal();
  factory DreamDatabase() {
    return instance;
  }

  // core of the dream connector
  // using a dummy core to avoid null pointer exception
  DreamCore _dreamCore = DreamCore.dummyCore();

  // streams
  final BehaviorSubject<List<Map<String, dynamic>>?> _databaseStream =
      BehaviorSubject<List<Map<String, dynamic>>?>.seeded(null);
  final BehaviorSubject<bool> _isConnectedStream =
      BehaviorSubject<bool>.seeded(false);

  /// Return a stream contains all the todoitems belong to the user
  get allItem {
    _readFromDatabaseAllItem();
    return _databaseStream;
  }

  /// Return a stream contains the loading status
  get loadingState => _dreamCore.isLoading;

  /// Return a stream contains the connection status
  get connectedState => _isConnectedStream;

  /// Set the dreamCore
  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  /// Read data from database every 10 seconds
  /// and update the stream
  /// This method is called when the app is opened
  connect() {
    if (_isConnectedStream.value == true) return;
    _readFromDatabaseAllItem();
    Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        // cancel timer if not connected
        _isConnectedStream.value ? null : timer.cancel();
        _readFromDatabaseAllItem()
            .then((value) => _isConnectedStream.add(true))
            .catchError((e) {
          _isConnectedStream.add(false);
        });
      },
    );
  }

  void disconnect() async {
    List<Map<String, dynamic>>? empty;
    _databaseStream.add(empty);
    _isConnectedStream.add(false);
  }

  /// Write one task item to server
  Future<void> writeOne(Map<String, dynamic> item) async {
    await _writeToDatabase(path: Path.all, items: [item])
        .then((value) => _readFromDatabaseAllItem());
  }

  /// Write all task items to server
  Future<void> writeAll(List<Map<String, dynamic>> items) async {
    await _writeToDatabase(path: Path.all, items: items)
        .then((value) => _readFromDatabaseAllItem());
  }

  /// Delete all the task item belong to user
  Future deleteAll() async {
    await _deleteFromDatabase(path: Path.all)
        .then((value) => _readFromDatabaseAllItem());
  }

  /// Read all the task item belong to the user
  /// and update the stream
  Future<void> _readFromDatabaseAllItem() async {
    final List<Map<String, dynamic>>? data = await _readFromDatabase(Path.all);
    _databaseStream.add(data);
  }

  /// Read task items from server
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

  /// Write task items to server
  Future _writeToDatabase({
    required Path path,
    required List<Map<String, dynamic>> items,
  }) async {
    loadingState.add(true);
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = headerResolver(authToken);
    // request body
    final String body = jsonEncode(items);

    logger('_writeToDatabase: ${body.toString().split(":").first}');

    await post(path: path, headers: headers, body: body, dreamCore: _dreamCore)
        .catchError((e) {
      throw Exception('faild to write to database: $e');
    });
    loadingState.add(false);
  }

  /// Delete task items from server
  Future<void> _deleteFromDatabase({
    required Path path,
  }) async {
    loadingState.add(true);
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = headerResolver(authToken);
    // todo change this request body
    final String body = jsonEncode([]);

    logger('_delete: ${body.toString().split(":").first}');

    await delete(
            path: path, headers: headers, body: body, dreamCore: _dreamCore)
        .catchError((e) => throw Exception('faild to delete: $e'));
    loadingState.add(false);
  }
}
