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

  // cache of the database
  List<Map<String, dynamic>> _databaseCache = [];

  // streams
  final BehaviorSubject<List<Map<String, dynamic>>?> _databaseStream =
      BehaviorSubject<List<Map<String, dynamic>>?>.seeded(null);
  final BehaviorSubject<bool> _isConnectStream =
      BehaviorSubject<bool>.seeded(false);

  /// Return a stream contains all the todoitems belong to the user
  get items {
    () {};
    return _databaseStream;
  }

  /// Return a stream contains the loading status
  get loadingState => _dreamCore.isLoading;

  /// Return a stream contains the connection status
  get connectState => _isConnectStream;

  /// Set the dreamCore
  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  /// Read data from database every 10 seconds
  /// and update the stream
  /// This method is called when the app is opened
  connect() {
    if (_isConnectStream.value == true) return;
    _isConnectStream.add(true);
    readMany();
    // todo find a way to check if the database is updated
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        logger(
            'Timer Active: ${timer.isActive}----------------------------------------------------------');
        // cancel timer if not connected
        _isConnectStream.value ? null : timer.cancel();
        await readMany()
            .then((value) => _isConnectStream.add(true))
            .catchError((e) {
          _isConnectStream.add(false);
        });
        logger(
            '----------------------------------------------------------------------------');
      },
    );
  }

  void disconnect() async {
    List<Map<String, dynamic>>? empty;
    _databaseCache = [];
    _databaseStream.add(empty);
    _isConnectStream.add(false);
  }

  /// Write one task item to server
  Future writeOne(Map<String, dynamic> item) async {
    await _writeToDatabase(path: Path.all, items: [item])
        .then((value) async => await readMany());
  }

  /// Write all task items to server
  Future writeMany(List<Map<String, dynamic>> items) async {
    await _writeToDatabase(path: Path.all, items: items)
        .then((value) async => await readMany());
  }

  /// Delete one task item from server
  Future deleteOne({required String tid, bool? refresh}) async {
    await _deleteFromDatabase(path: Path.single, tid: tid)
        .then((value) async => refresh ?? await readMany());
  }

  /// Delete all the task item belong to user
  Future deleteMany() async {
    await _deleteFromDatabase(path: Path.all)
        .then((value) async => await readMany());
  }

  /// Read all the task item belong to the user
  /// and update the stream
  Future readMany() async {
    await _readFromDatabase(Path.all).then((value) {
      _databaseCache = value ?? [];
      _databaseCache.sort(
        (a, b) {
          if (int.parse(a['tid']) > int.parse(b['tid'])) {
            return 1;
          }
          return 0;
        },
      );
      _databaseStream.add(_databaseCache);
    });
  }

  Future editOne({
    required String tid,
    String? section,
    String? context,
    String? memeber,
    bool? isDone,
    String? updateBy,
    DateTime? dueAt,
  }) async {
    try {
      var data = await DreamDatabase.instance.items;
      var taskItem = data.value
          .where(
            (element) => element['tid'] == tid,
          )
          .toList()[0];

      // taskItem['section'] = section ?? taskItem['section'];
      // taskItem['context'] = context ?? taskItem['context'];
      // taskItem['member'] = memeber ?? taskItem['member'];
      taskItem['isDone'] = isDone ?? taskItem['isDone'];
      // taskItem['update_by'] = updateBy ?? taskItem['update_by'];
      // taskItem['due_at'] = dueAt ?? taskItem['due_at'];
      await DreamDatabase.instance.deleteOne(tid: tid);
      await DreamDatabase.instance.writeOne(taskItem);
    } catch (e) {
      logger(e.toString());
      throw Exception(e);
    }
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
    String? tid,
  }) async {
    loadingState.add(true);
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = headerResolver(authToken);
    // request body
    final String body = jsonEncode(items);
    final Uri url =
        await pathResolver(path: path, dreamCore: _dreamCore, tid: tid);

    logger('_writeToDatabase: ${body.toString().split(":").first}');

    await post(url: url, headers: headers, body: body).catchError((e) {
      throw Exception('faild to write to database: $e');
    });
    loadingState.add(false);
  }

  /// Delete task items from server
  Future _deleteFromDatabase({
    required Path path,
    String? tid,
  }) async {
    loadingState.add(true);
    final authToken = await DreamAuth.instance.authToekn;
    final Map<String, String> headers = headerResolver(authToken);
    // todo change this request body
    final String body = jsonEncode([]);
    final Uri url =
        await pathResolver(path: path, dreamCore: _dreamCore, tid: tid);

    logger('_delete: ${body.toString().split(":").first}');

    await delete(url: url, headers: headers, body: body)
        .catchError((e) => throw Exception('faild to delete: $e'));
    loadingState.add(false);
  }
}
