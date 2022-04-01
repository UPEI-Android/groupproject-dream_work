// ignore: file_names
import 'dart:convert';
import 'package:dream_work/dream_connector/dreamCore.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

enum Path {
  register,
  login,
  logout,
}

// demo
// DreamCore dreamCore = DreamCore(
//     ServerUrl: "localhost", ServerPort: 3000, ServerProtocol: "http");
// DreamAuth.instance.dreamCore = dreamCore;

// // demo for register
// DreamAuth.instance
//     .createUserWithEmailAndPassword(
//         email: 'terdwry@test2.com', password: 'test')
//     .catchError((e) {
//   print(e); // this mean user name has been take
// });

// // demo for sign in
// DreamAuth.instance
//     .loginWithEmailAndPassword(
//         email: 'terdwry@test2.com', password: 'test')
//     .catchError((e) {
//   print(e);
// });

/// easy auth with backend
class DreamAuth {
  static final DreamAuth instance = DreamAuth._internal();
  late DreamCore _dreamCore;

  // auth infomation
  String? _authToken;
  //Map<String, dynamic>? _payload;

  DreamAuth._internal(); // private constructor

  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  final BehaviorSubject _authStateStream =
      BehaviorSubject<Map<String, dynamic>?>.seeded(null);

  /// Return the user information in the authtoken
  /// - username
  /// - name
  /// - email
  /// - iat
  get authStateStream => _authStateStream;

  /// Attmpts to logout
  Future logout() async {
    _authToken = null;
    Map<String, dynamic>? empty;
    _authStateStream.add(empty);
  }

  /// Attempts to register a user with the given email address password and optional username.
  ///
  /// If successful, will not throw an error.
  ///
  /// If unsuccessful, throw an error.
  Future createUserWithEmailAndPassword({
    String? userName,
    required String email,
    required String password,
  }) async {
    const Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final String body = jsonEncode({
      'username': userName ?? email,
      'email': email,
      'password': password,
    });

    _post(path: Path.register, headers: headers, body: body);
  }

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// If successful, [authState] will be populated with the user's auth state.
  ///
  /// If unsuccessful, throw Error.
  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    const Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final String body = jsonEncode({
      'email': email,
      'password': password,
    });

    _authToken = await _post(path: Path.login, headers: headers, body: body);
    _authStateStream.add(Jwt.parseJwt(_authToken!));
  }

  /// Attempts to sent post request to server.
  ///
  /// If state code is 200 return the response body.
  ///
  /// If state code is not 200 throw Error.
  Future<String> _post({
    required Path path,
    required Map<String, String> headers,
    required String body,
  }) async {
    late String _path;
    switch (path) {
      case Path.register:
        _path = '/api/auth/register';
        break;
      case Path.login:
        _path = '/api/auth/login';
        break;
      case Path.logout:
        _path = '/api/auth/logout';
        break;
    }

    final Uri serverUrl = Uri.parse(
        '${_dreamCore.ServerProtocol}://${_dreamCore.ServerUrl}:${_dreamCore.ServerPort}$_path');
    final http.Client client = http.Client();
    final response = await client.post(serverUrl, headers: headers, body: body);
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return response.body;
  }

  factory DreamAuth() {
    return DreamAuth._internal();
  }
}
