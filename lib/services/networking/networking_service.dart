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
      await generateAccessToken();
      accessToken =
          await SharedPreferenceService().getUserToken(key: kAccessTokenKey);
    }

    try {
      Map<String, String> headers = {};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
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
          await generateAccessToken();
          accessToken = await SharedPreferenceService()
              .getUserToken(key: kAccessTokenKey);

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
      Map<String, String>? headers,
      bool tokenRequired = true}) async {
    String? accessToken =
        await SharedPreferenceService().getUserToken(key: kAccessTokenKey);

    if (accessToken == null) {
      await generateAccessToken();
      accessToken =
          await SharedPreferenceService().getUserToken(key: kAccessTokenKey);
    }

    try {
      Map<String, String> headers = {};
      if (tokenRequired) {
        // check if token is required then add bearer token in header
        if (tokenRequired) {
          headers.putIfAbsent('Content-Type', () => 'application/json');
          headers.putIfAbsent('Authorization', () => 'OAuth $accessToken');
        }
      }
      var response;
      try {
        response =
            await http.post(Uri.parse(path), body: body, headers: headers);
      }
      catch(e){
        print(e);
      }

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
          await generateAccessToken();
          accessToken = await SharedPreferenceService()
              .getUserToken(key: kAccessTokenKey);

          final response =
              await http.post(Uri.parse(path), body: body, headers: headers);
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

  Future<void> generateAccessToken() async {
    var tokenResponse = await http
        .post(Uri.parse('${Endpoints.kBaseURL}$authURL'), body: authJson);

    if (tokenResponse.statusCode == 200) {
      try {
        var accessTokenBody = jsonDecode(tokenResponse.body);
        var accessToken = accessTokenBody['access_token'];
        SharedPreferenceService().setUserToken(authToken: accessToken);
      } catch (e) {
        print('Access token error: $e');
      }
    }
  }
}
