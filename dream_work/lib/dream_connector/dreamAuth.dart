// ignore: file_names
import 'dart:convert';
import 'utils/utils.dart';
import 'package:dream_work/dream_connector/dreamCore.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:rxdart/rxdart.dart';

/// easy auth with backend
class DreamAuth {
  static final DreamAuth instance = DreamAuth._internal();
  late DreamCore _dreamCore;

  String? _authToken; // auth infomation
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
  get authState => _authStateStream;

  get authToekn {
    if (_authToken == null) {
      throw Exception('AuthToken is null');
    }

    if (kDebugMode) {
      print('dreamAuth_authToken: $_authToken');
    }

    return json.decode(_authToken!)['accessToken'];
  }

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

    if (kDebugMode) {
      print('dreamAuth_createUserWithEmailAndPassword: $body');
    }

    await post(
        path: Path.register,
        headers: headers,
        body: body,
        dreamCore: _dreamCore);
    await loginWithEmailAndPassword(email: email, password: password);
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

    if (kDebugMode) {
      print('dreamAuth_loginWithEmailAndPassword: $body');
    }

    _authToken = await post(
        path: Path.login, headers: headers, body: body, dreamCore: _dreamCore);
    _authStateStream.add(Jwt.parseJwt(_authToken!));
  }

  factory DreamAuth() {
    return DreamAuth._internal();
  }
}
