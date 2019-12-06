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

  void setBucket(String bucket) {
    _bucket = bucket;
  }

  void setDataset(String dataset) {
    _dataset = dataset;
  }

  void setAuthToken(String auth_token) {
    _auth_token = auth_token;
  }

  dynamic insert(String container, Map<String, dynamic> data) async {
    if(container == null) {
      throw new sCError("Please define a container name as the first parameter.");
    }

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

  dynamic update(String container, int row, Map<String, dynamic> data) async {
    if(container == null) {
      throw new sCError("Please define a container name as the first parameter.");
    }

    if(row == null) {
      throw new sCError("Please define a rowset id as the second parameter.");
    }

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
          'row': row,
          'data': jsonEncode(data)
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  dynamic delete(String container, int row) async {
    if(container == null) {
      throw new sCError("Please define a container name as the first parameter.");
    }

    if(row == null) {
      throw new sCError("Please define a rowset id as the second parameter.");
    }

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.delete(config.api_endpoint,
        headers: headers,
        body: {
          'container': container, 
          'dataset': _dataset,
          'row': row
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  },

  void getAll(String container, [String sorting, int start, int limit]) async {
    if (container == null) {
      throw new sCError("Please define a container as the first parameter.");
    }

    if (start == null) {
      start = "";
    }

    if(limit == null) {
      limit = "";
    }

    if(sorting == null) {
      sorting = "asc";
    }

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.get(config.api_endpoint,
        headers: headers,
        body: {
          'container': container, 
          'dataset': _dataset,
          'order': sorting,
          'start': start,
          'limit': limit
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  dynamic getById(String container, int row) {
    if(container == null) {
      throw new sCError("Please define a container name as the first parameter.");
    }

    if(row == null) {
      throw new sCError("Please define a rowset id as the second parameter.");
    }

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.get(config.api_endpoint,
        headers: headers,
        body: {
          'container': container, 
          'dataset': _dataset,
          'row': row
        }
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }
}