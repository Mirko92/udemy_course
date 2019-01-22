class MyHttpResponse {
  bool result;
  String message;

  MyHttpResponse({this.result, this.message});
}

///Request Body Payload
///to SignIn with FireBase
class FireBaseAuthRequest {
  ///The email the user is signing in with.
  String email;

  ///The password for the account.
  String password;

  ///Whether or not to return an ID and refresh token. Should always be true.
  bool secureToken;

  FireBaseAuthRequest({this.email, this.password, this.secureToken = true});

  Map<String, dynamic> toJson() =>
      {'password': password, 'email': email, 'secureToken': secureToken};
}

///Response body received from SignIn request
class FireBaseAuthResponse {
  ///The request type, always "identitytoolkit#VerifyPasswordResponse".
  String kind;

  ///A Firebase Auth ID token for the authenticated user.
  String idToken;

  ///The email for the authenticated user.
  String email;

  ///A Firebase Auth refresh token for the authenticated user.
  String refreshToken;

  ///The number of seconds in which the ID token expires.
  String expiresIn;

  ///The uid of the authenticated user.
  String localId;

  ///Whether the email is for an existing account.
  bool registered;

  FireBaseAuthResponse.fromJson(Map json)
      : kind = json['kind'],
        idToken = json['idToken'],
        email = json['email'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'],
        localId = json['localId'],
        registered = json['registered'] == 'true';
}

class FireBaseResponse {
  ///The request type, always "identitytoolkit#VerifyCustomTokenResponse".
  String kind;

  ///A Firebase Auth ID token generated from the provided custom token.
  String idToken;

  ///A Firebase Auth refresh token generated from the provided custom token.
  String refreshToken;

  ///The number of seconds in which the ID token expires.
  String expiresIn;

  _FireBaseError error;

  FireBaseResponse.fromJson(Map<String, dynamic> json)
      : kind = json['kind'],
        idToken = json['idToken'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'] {
    var e = json['error'];
    error = e != null ? _FireBaseError.fromJson(json['error']) : null;
  }
}

class _FireBaseError {
  List<_FireBaseErrorDescriptor> errors;
  int code;
  String message;

  _FireBaseError.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'] {
    var e = json['errors'];
    e != null ? e.map((x) => _FireBaseErrorDescriptor.fromJson(x)) : null;
  }
}

class _FireBaseErrorDescriptor {
  String domain;
  String reason;
  String message;

  _FireBaseErrorDescriptor.fromJson(Map<String, dynamic> json)
      : domain = json['domain'],
        reason = json['reason'],
        message = json['message'];
}

enum ErrorMessages { EMAIL_EXISTS }

// {
//   "error": {
//     "errors": [
//       {
//         "domain": "global",
//         "reason": "invalid",
//         "message": "CREDENTIAL_TOO_OLD_LOGIN_AGAIN"
//       }
//     ],
//     "code": 400,
//     "message": "CREDENTIAL_TOO_OLD_LOGIN_AGAIN"
//   }
// }
