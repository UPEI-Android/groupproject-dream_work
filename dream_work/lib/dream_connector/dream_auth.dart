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
  late DreamCore _dreamCore;
  // auth infomation
  String? _authToken;

  /// Stream of user information
  /// - username
  /// - name
  /// - email
  /// - iat
  final BehaviorSubject _authStateStream =
      BehaviorSubject<Map<String, dynamic>?>.seeded(null);

  /// Stream of [bool]
  final BehaviorSubject _isLoadingStream = BehaviorSubject<bool>.seeded(false);

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
  get isLoading => _isLoadingStream;

  // todo update authThoken with new token
  /// getter for [auth]
  get authToekn {
    _authToken == null ? throw Exception('AuthToken is null') : null;
    logger('dreamAuth_authToken: $_authToken');
    return json.decode(_authToken!)['accessToken'];
  }

  /// Attmpts to logout
  Future logout() async {
    loading(() async {
      await _dreamCore.close();
      _authToken = null;
      Map<String, dynamic>? empty;
      _authStateStream.add(empty);
      logger('dreamAuth_logout: success');
    });
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
    loading(() async {
      final Map<String, String> headers = headerResolver();
      final String body = jsonEncode({
        'username': userName ?? email,
        'email': email,
        'password': password,
      });

      logger('dreamAuth_createUserWithEmailAndPassword: $body');

      await post(
          path: Path.register,
          headers: headers,
          body: body,
          dreamCore: _dreamCore);
      await loginWithEmailAndPassword(email: email, password: password);
    });
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
    loading(() async {
      final Map<String, String> headers = headerResolver();
      final String body = jsonEncode({
        'email': email,
        'password': password,
      });

      logger('dreamAuth_loginWithEmailAndPassword: $body');

      _authToken = await post(
          path: Path.login,
          headers: headers,
          body: body,
          dreamCore: _dreamCore);
      _authStateStream.add(Jwt.parseJwt(_authToken!));
    });
  }

  Future loading(Function callBack) async {
    _isLoadingStream.add(true);
    await callBack();
    _isLoadingStream.add(false);
  }
}
