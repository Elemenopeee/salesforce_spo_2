import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../storage/shared_preferences_service.dart';
import 'package:http/http.dart' as http;
import 'http_response.dart';

const kBaseUrl = '';

class HttpService {
  // get call for http
  doGet(
      {required String path,
        Map<String, dynamic>? params,
        bool tokenRequired = false}) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(kBaseUrl, path, params);
      final response = await http.get(uri, headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponse(
              status: true, message: '', data: data);
        case 401: // token expired
        case 403:
          return HttpResponse(
              status: false, message: '');
        case 400:
          return HttpResponse(
              status: false, message: '');
        case 404: // API not found
          return HttpResponse(
              status: false,
              message: '');
        case 504: // Timeout
          return HttpResponse(
              status: false, message: '');
        default:
          return HttpResponse(status: false, message: '');
      }
    } on SocketException {
      return HttpResponse(
          status: false, message: '');
    } catch (error) {
      return HttpResponse(status: false, message: error.toString());
    }
  }

  // post call on http
  doPost(
      {required String path,
        dynamic body,
        dynamic params,
        bool tokenRequired = false}) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      // check if token is required then add bearer token in header
      if (tokenRequired) {
        SharedPreferenceService sharedPreferences = SharedPreferenceService();
        // GET TOKEN
        String? token = await sharedPreferences.getUserToken(key: 'token');
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
      var uri = Uri.https(kBaseUrl, path, params);
      final response =
      await http.post(uri, body: json.encode(body), headers: headers);
      dynamic data; // set decoded body response
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      log('POST_CALL${response.statusCode}');
      switch (response.statusCode) {
        case 200: // API success
        case 201:
        case 204:
          return HttpResponse(
              status: true, message: '', data: data);
        case 401: // token expired
        case 403:
          return HttpResponse(
              status: false, message: '');
        case 400:
          return HttpResponse(
              status: false, message: '');
        case 404: // API not found
          return HttpResponse(
              status: false,
              message: '');
        case 504: // Timeout
          return HttpResponse(
              status: false, message: '');
        default:
          return HttpResponse(status: false, message: '');
      }
    } on SocketException {
      return HttpResponse(
          status: false, message: '');
    } catch (error) {
      return HttpResponse(status: false, message: error.toString());
    }
  }
}
