import 'package:http/http.dart' as http;
import './config.dart' as config;

class sCAuth {
  String 
    _app_id, 
    _app_secret;

  sCAuth(String app_id, String app_secret) {
    _app_id = app_id;
    _app_secret = app_secret;
  }

  /// Adds a new user to the authentication system.
  ///
  /// @param email The new email
  /// @param password The new password
  /// @param language A two letter language code (ex. de, en)
  /// @returns A Response instance, if the request has been finished completed
  Future<dynamic> registerEmailPassword(String email, String password, String language) async {
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
}