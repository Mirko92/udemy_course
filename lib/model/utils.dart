class MyHttpResponse {
  bool result;
  String message;

  MyHttpResponse({this.result, this.message});
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
    e != null ? e.map((x)=>_FireBaseErrorDescriptor.fromJson(x)) : null;
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

