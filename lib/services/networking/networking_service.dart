import 'dart:convert';
import 'dart:io';

import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../storage/shared_preferences_service.dart';
import 'package:http/http.dart' as http;
import 'http_response.dart';

class HttpService {
  // get call for http
  Future<HttpResponse> doGet(
      {required String path,
      Map<String, dynamic>? params,
      bool tokenRequired = true}) async {
    String? accessToken =
        await SharedPreferenceService().getUserToken(key: kAccessTokenKey);

    if (accessToken == null) {
      var tokenApi = await doPost(
          path: '${Endpoints.kBaseURL}$authURL',
          body: authJson,
          headers: authHeaders);

      String accessToken = tokenApi.data['access_token'];

      SharedPreferenceService().setUserToken(authToken: accessToken);
    }

    try {
      Map<String, String> headers = {};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        // SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        // String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'OAuth $accessToken');
      }
      // var uri = Uri.https(kBaseURL, path, params);
      final response = await http.get(Uri.parse(path), headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponse(status: true, message: '', data: data);
        case 401: // token expired
        case 403:
          var tokenApi = await doPost(
              path: '${Endpoints.kBaseURL}$authURL',
              body: authJson,
              headers: authHeaders);

          String accessToken = tokenApi.data['access_token'];
          SharedPreferenceService().setUserToken(authToken: accessToken);

          final response = await http.get(Uri.parse(path), headers: headers);
          dynamic data; // set decoded body response
          if (response.body.isNotEmpty) {
            data = json.decode(response.body);
          }

          if (response.statusCode == 200) {
            return HttpResponse(status: true, message: '', data: data);
          }

          return HttpResponse(status: false, message: '');
        case 400:
          return HttpResponse(status: false, message: '');
        case 404: // API not found
          return HttpResponse(status: false, message: '');
        case 504: // Timeout
          return HttpResponse(status: false, message: '');
        default:
          return HttpResponse(status: false, message: '');
      }
    } on SocketException {
      return HttpResponse(status: false, message: '');
    } catch (error) {
      return HttpResponse(status: false, message: error.toString());
    }
  }

  // post call on http
  Future<HttpResponse> doPost(
      {required String path,
      dynamic body,
      dynamic params,
      dynamic headers,
      bool tokenRequired = false}) async {

    String? accessToken =
    await SharedPreferenceService().getUserToken(key: kAccessTokenKey);

    if (accessToken == null) {
      var tokenApi = await doPost(
          path: '${Endpoints.kBaseURL}$authURL',
          body: authJson,
          headers: authHeaders);

      String accessToken = tokenApi.data['access_token'];

      SharedPreferenceService().setUserToken(authToken: accessToken);
    }

    try {
      Map<String, String> temporaryHeaders = {};
      if (tokenRequired) {
        temporaryHeaders.putIfAbsent('Content-Type', () => 'application/json');
        temporaryHeaders.putIfAbsent('Authorization', () => 'OAuth $accessToken');
      }

      final response =
          await http.post(Uri.parse(path), body: body, headers: temporaryHeaders);

      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponse(status: true, message: '', data: data);
        case 401: // token expired
        case 403:
        var tokenApi = await doPost(
            path: '${Endpoints.kBaseURL}$authURL',
            body: authJson,
            headers: authHeaders);

        String accessToken = tokenApi.data['access_token'];
        SharedPreferenceService().setUserToken(authToken: accessToken);

        final response = await http.get(Uri.parse(path), headers: headers);
        dynamic data; // set decoded body response
        if (response.body.isNotEmpty) {
          data = json.decode(response.body);
        }

        if (response.statusCode == 200) {
          return HttpResponse(status: true, message: '', data: data);
        }
          return HttpResponse(status: false, message: '');
        case 400:
          return HttpResponse(status: false, message: '');
        case 404: // API not found
          return HttpResponse(status: false, message: '');
        case 504: // Timeout
          return HttpResponse(status: false, message: '');
        default:
          return HttpResponse(status: false, message: '');
      }
    } on SocketException {
      return HttpResponse(status: false, message: '');
    } catch (error) {
      return HttpResponse(status: false, message: error.toString());
    }
  }
}
