import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';

import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient({Client? client}) : _client = client ?? Client();

  dynamic get(String path,
      {Map<dynamic, dynamic>? params, String? token}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequest();
      case 401:
        throw UnauthorisedException();
      case 403:
        throw Forbidden();
      case 404:
        throw NotFound();
      case 422:
        throw UnprocessableEntity();
      case 500:
        throw InternalServerError();
      case 501:
        throw InternalServerError();
      case 503:
        throw ServerNotAvailableError();
      default:
        throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path,
      {Map<dynamic, dynamic>? params, String? token}) async {
    final response = await _client.post(
      getPath(path, null),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    log(response.body);
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequest();
      case 401:
        throw UnauthorisedException();
      case 403:
        throw Forbidden();
      case 404:
        throw NotFound();
      case 422:
        throw UnprocessableEntity();
      case 500:
        throw InternalServerError();
      case 501:
        throw InternalServerError();
      case 503:
        throw ServerNotAvailableError();
      default:
        throw Exception(response.reasonPhrase);
    }
  }

  dynamic patch(String path,
      {Map<dynamic, dynamic>? params, String? token}) async {
    final response = await _client.patch(
      getPath(path, null),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequest();
      case 401:
        throw UnauthorisedException();
      case 403:
        throw Forbidden();
      case 404:
        throw NotFound();
      case 422:
        throw UnprocessableEntity();
      case 500:
        throw InternalServerError();
      case 501:
        throw InternalServerError();
      case 503:
        throw ServerNotAvailableError();
      case 504:
        throw InternalServerError();
      default:
        throw Exception(response.reasonPhrase);
    }
  }

  dynamic deleteWithBody(String path,
      {Map<dynamic, dynamic>? params, required String token}) async {
    Request request = Request('DELETE', getPath(path, null));
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => Response.fromStream(value),
        );

    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequest();
      case 401:
        throw UnauthorisedException();
      case 403:
        throw Forbidden();
      case 404:
        throw NotFound();
      case 422:
        throw UnprocessableEntity();
      case 500:
        throw InternalServerError();

      case 501:
        throw InternalServerError();
      case 503:
        throw ServerNotAvailableError();
      default:
        throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {});
    }

    return Uri.parse('${ApiConstants.baseUrl}/$path');
  }
}
