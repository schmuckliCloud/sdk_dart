import 'package:http/http.dart' as http;
import 'dart:convert';
import './config.dart' as config;
import './sCNotify.dart';

class sCStorage {
  String _app_id, _app_secret;

  int _bucket;
  String _dataset, _auth_token;

  sCStorage(String app_id, app_secret) {
    _app_id = app_id;
    _app_secret = app_secret;
  }

  void setBucket(int bucket) {
    _bucket = bucket;
  }

  void setDataset(String dataset) {
    _dataset = dataset;
  }

  void setAuthToken(String auth_token) {
    _auth_token = auth_token;
    _dataset = "";
  }

  dynamic insert(String container, Map<String, dynamic> data) async {
    if (_bucket == null) {
      throw new sCNotify("Please define a bucket first.", sCNotifyTypes.ERROR);
    }

    if (_dataset == null) {
      throw new sCNotify("Please define a dataset as well or provide an auth token.", sCNotifyTypes.WARNING);
    }

    if(container == null) {
      throw new sCNotify("Please define a container name as the first parameter.", sCNotifyTypes.ERROR);
    }

    var client = new http.Client();

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.post(config.api_endpoint,
        headers: headers,
        body: {
          'bucket': _bucket,
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
    if (_bucket == null) {
      throw new sCNotify("Please define a bucket first.", sCNotifyTypes.ERROR);
    }

    if (_dataset == null) {
      throw new sCNotify("Please define a dataset as well or provide an auth token.", sCNotifyTypes.WARNING);
    }

    if(container == null) {
      throw new sCNotify("Please define a container name as the first parameter.", sCNotifyTypes.ERROR);
    }

    if(row == null) {
      throw new sCNotify("Please define a rowset id as the second parameter.", sCNotifyTypes.ERROR);
    }

    var client = new http.Client();

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
    if (_bucket == null) {
      throw new sCNotify("Please define a bucket first.", sCNotifyTypes.ERROR);
    }

    if (_dataset == null) {
      throw new sCNotify("Please define a dataset as well or provide an auth token.", sCNotifyTypes.WARNING);
    }

    if(container == null) {
      throw new sCNotify("Please define a container name as the first parameter.", sCNotifyTypes.ERROR);
    }

    if(row == null) {
      throw new sCNotify("Please define a rowset id as the second parameter.", sCNotifyTypes.ERROR);
    }
    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      var request = http.Request('DELETE', Uri.parse(config.api_endpoint));
      request.headers.addAll(headers);
      request.bodyFields = {
          'bucket': _bucket.toString(),
          'container': container,
          'dataset': _dataset,
          'row': row.toString()
        };

      return await request.send();

    } catch(e) {
      return e;
    }
  }

  dynamic getAll(String container, [String sorting, int start, int limit]) async {
    if (_bucket == null) {
      throw new sCNotify("Please define a bucket first.", sCNotifyTypes.ERROR);
    }

    if (_dataset == null) {
      throw new sCNotify("Please define a dataset as well or provide an auth token.", sCNotifyTypes.WARNING);
    }

    if (container == null) {
      throw new sCNotify("Please define a container name as the first parameter.", sCNotifyTypes.ERROR);
    }

    if(sorting == null) {
      sorting = "asc";
    }

    var client = new http.Client();

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      String url = config.api_endpoint + "?" +
        "bucket=" + _bucket.toString() + "&" +
        "container=" + container + "&" +
        "dataset=" + _dataset + "&" + 
        "order=" + sorting + "&" + 
        "start=" + (start == 0 ? "" : start.toString()) + "&" +
        "limit=" + (limit == 0 ? "" : limit.toString());

      return await client.get(url,
        headers: headers
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }

  dynamic getById(String container, int row) async {
    if (_bucket == null) {
      throw new sCNotify("Please define a bucket first.", sCNotifyTypes.ERROR);
    }

    if (_dataset == null) {
      throw new sCNotify("Please define a dataset as well or provide an auth token.", sCNotifyTypes.WARNING);
    }

    if(container == null) {
      throw new sCNotify("Please define a container name as the first parameter.", sCNotifyTypes.ERROR);
    }

    if(row == null) {
      throw new sCNotify("Please define a rowset id as the second parameter.", sCNotifyTypes.ERROR);
    }

    var client = http.Client();

    try {
      Map<String, String> headers = {
        'appid': _app_id,
        'appsecret': _app_secret,
        'authtoken': _auth_token
      };

      return await client.get(config.api_endpoint + "?" +
        "bucket=" + _bucket.toString() + "&" +
        "container=" + container + "&" +
        "dataset=" + _dataset + "&" + 
        "row=" + row.toString(),
        headers: headers
      );

    } catch(e) {
      return e;
    } finally {
      client.close();
    }
  }
}