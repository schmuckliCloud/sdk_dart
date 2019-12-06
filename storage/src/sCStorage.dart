import 'package:http/http.dart' as http;
import './config.dart' as config;

class sCStorage {
  String _app_id, _app_secret;

  int _bucket;
  String _dataset, _auth_token;

  sCStorage(String app_id, app_secret) {
    _app_id = app_id;
    _app_secret = app_secret;
  }

  setBucket(String bucket) {
    _bucket = bucket;
  }

  setDataset(String dataset) {
    _dataset = dataset;
  }

  setAuthToken(String auth_token) {
    _auth_token = auth_token;
  }

  insert(String container, Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.post(config.api_endpoint,
        headers: headers,
        body: {
          'container': container, 
          'dataset': _dataset,
          'data': jsonEncode(data)
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  update(String container, int row, Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.put(config.api_endpoint,
        headers: headers,
        body: {
          'container': container, 
          'dataset': _dataset,
          'row_id': row_id
          'data': jsonEncode(data)
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }
}