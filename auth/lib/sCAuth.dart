import 'package:http/http.dart' as http;
import './config.dart' as config;
import './sCNotify.dart';

class sCAuth {
  String 
    _app_id, 
    _app_secret;

  /// Creates an instance to use the schmuckliCloud Authentication library.
  sCAuth(String app_id, String app_secret) {
    _app_id = app_id;
    _app_secret = app_secret;
  }

  /// Adds a new user to the authentication system.
  /// @param email The new email
  /// @param password The new password
  /// @param language A two letter language code (ex. de, en)
  /// @returns A Response instance, if the request has been finished completed
  dynamic registerEmailPassword(String email, String password, String language) async {
    if(email == null) {
      throw new sCNotify("Please define an email as the first parameter.", sCNotify.ERROR);
    }

    if (password == null) {
      throw new sCNotify("Please define a password as the second parameter.");
    }

    if (language == null) {
      new sCNotify("If you want to use localized messages, please provide an language in short form (en, de) as the thrid parameter.");
    }

    var client = new http.Client();
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret
      };

      return await client.post(config.api_endpoint + "emailpassword.php",
        headers: headers,
        body: {
          'email': email, 
          'password': password,
          'lang': language
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  /// Authorizes the user with email and password. In the body you will find the session token.
  /// @param email The email of the user
  /// @param password The password of the user
  /// @returns If it was successful, it will provide the session token in the body. Save it somewhere safe on the client.
  dynamic authorizeEmailPassword(String email, String password) async {
    if(email == null) {
      throw new sCNotify("Please define an email as the first parameter.", sCNotify.ERROR);
    }

    if(password == null) {
      throw new sCNotify("Please define an unhashed password as the second parameter.", sCNotify.ERROR);
    }

    var client = new http.Client();
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret
      };

      return await client.put(config.api_endpoint + "emailpassword.php",
        headers: headers,
        body: {
          'email': email, 
          'password': password
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  /// If the user has forgottten his password, just provide the email and it will send an email with a password change link.
  /// @param email The email from the account (ex. EmailPassword or any other provider)
  dynamic requestResetPassword(String email) async {
    if(email == null) {
      throw new sCNotify("Please define an email of the user as the first parameter.", sCNotifyTypes.ERROR);
    }

    var client = new http.Client();
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret
      };

      return await client.put(config.api_endpoint,
        headers: headers,
        body: {
          'function': 'request_reset_password',
          'email': email
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  /// Checks if the token provided is still valid and matches with the server.
  /// @param token The session token, which you got, when the user has been authorized.
  dynamic checkSession(String token) async {
    if (token == null) {
      throw new sCNotify("Please define a token as the first parameter.", sCNotifyTypes.ERROR);
    }

    var client = new http.Client();
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': token
      };

      return await client.get(config.api_endpoint,
        headers: headers
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }
}