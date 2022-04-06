import 'package:jwt_decode/jwt_decode.dart';
import 'package:rxdart/rxdart.dart';
import 'utils/utils.dart';
import 'dream_core.dart';
import 'dart:convert';

/// Easy use auth
class DreamAuth {
  // singleton
  static final DreamAuth instance = DreamAuth._internal();
  DreamAuth._internal(); // private constructor
  factory DreamAuth() {
    return DreamAuth._internal();
  }

  // core of the dream connector
  // using a dummy core to avoid null pointer exception
  DreamCore _dreamCore = DreamCore.dummyCore();
  // auth infomation
  String? _authToken;

  /// Stream of user information
  /// - username
  /// - name
  /// - email
  /// - iat
  final BehaviorSubject _authStateStream =
      BehaviorSubject<Map<String, dynamic>?>.seeded(null);

  /// setter for [_dreamCore]
  set dreamCore(DreamCore _dreamCore) {
    this._dreamCore = _dreamCore;
  }

  /// getter for [_authStateStream]
  /// Return a stream of user information
  /// - username
  /// - name
  /// - email
  /// - iat
  get authState => _authStateStream;

  /// getter for [_isLoadingStream]
  /// return a stream of [bool]
  get isLoading => _dreamCore.isLoading;

  // todo update authThoken with new token
  /// getter for [auth]
  get authToekn {
    _authToken == null ? throw Exception('AuthToken is null') : null;
    logger('dreamAuth_authToken: ${_authToken != null ? 'loaded' : 'null'}');
    return json.decode(_authToken!)['accessToken'];
  }

  /// Attmpts to logout
  Future logout() async {
    await _dreamCore.close();
    _authToken = null;
    Map<String, dynamic>? empty;
    _authStateStream.add(empty);
    logger('dreamAuth_logout: success');
  }

  /// Attempts to register a user with the given email address password and optional username.
  ///
  /// If successful, will not throw an error.
  ///
  /// If unsuccessful, throw an error.
  Future createUserWithEmailAndPassword({
    String? name,
    required String email,
    required String password,
  }) async {
    final Map<String, String> headers = headerResolver();
    final String body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });
    final Uri url =
        await pathResolver(path: Path.register, dreamCore: _dreamCore);

    logger('dreamAuth_createUserWithEmailAndPassword: $body');

    await post(url: url, headers: headers, body: body);
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
    final Map<String, String> headers = headerResolver();
    final String body = jsonEncode({
      'email': email,
      'password': password,
    });
    final Uri url = await pathResolver(path: Path.login, dreamCore: _dreamCore);

    logger('dreamAuth_loginWithEmailAndPassword: $body');

    _authToken = await post(url: url, headers: headers, body: body);
    _authStateStream.add(Jwt.parseJwt(_authToken!));
  }
}
