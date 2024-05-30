import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../../features/auth/controller/auth_controller.dart';


enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiClient {
/*
  static String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYW5ib25ha2kuYmFhZGhhbi5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MjM0MzU5MDIsImV4cCI6Mzc4MzQzNTkwMiwibmJmIjoxNjIzNDM1OTAyLCJqdGkiOiJyb2ZUaFVUVE9Zc1FhSmExIiwic3ViIjo0OCwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.Q64igZeJb3cB1MzLGkV4vhCcwlrrKRPPFO4xkokoqH8";
*/

//  static String token;

  static Future<http.Response?> Request(
      { required String url,
      Method method = Method.GET,
      var body,
      bool enableHeader = false}) async {
    http.Response response;

    try {
      var _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthController.to.token}'
      };
      print("Token...................  ${AuthController.to.token}");
      print("Header...................  ${_header}");

      if (method == Method.POST) {
        if (enableHeader) {
          response = await http.post(Uri.parse(url), body: body, headers: _header);
        } else {
          response = await http.post(Uri.parse(url), body: body);
        }
      } else if (method == Method.DELETE) {
        response = await http.delete(Uri.parse(url));
      } else if (method == Method.PATCH) {
        response = await http.patch(Uri.parse(url), body: body);
      } else {
        if (enableHeader) {
          response = await http.get(Uri.parse(url), headers: _header);
        } else {
          response = await http.get(Uri.parse(url));
        }
      }
      showData(
          url: url,
          body: body,
          method: method,
          response: response.body,
          header: enableHeader ? header : "no header");

      return response;
    } catch (e) {
      print("Request Error :: $e");
      return null ;
    }
  }

  static Future RequestWithFile(
      {required String url,
      bool magic_method_allow = false,
      required Map<String, String> body,
      List<String>? fileKey,
      List<File>? files,
      Method method = Method.POST,
      Map? headerData,
      bool headerRequired = false}) async {
    var result;
    var uri = Uri.parse(url);
    var request;
    if (method == Method.POST) {
      request = new http.MultipartRequest("POST", uri)..fields.addAll(body);
    } else if (method == Method.PATCH) {
      request = new http.MultipartRequest("PATCH", uri)..fields.addAll(body);
    } else if (method == Method.PUT) {
      request = new http.MultipartRequest("PUT", uri)..fields.addAll(body);
    }

    if (files != null && fileKey != null) {
      for (int i = 0; i < fileKey.length; i++) {
        print("Header FIle  Key ${fileKey[i]}");
        print("Header FIle   ${files[i].path}");

        var stream =
            new http.ByteStream(DelegatingStream.typed(files[i].openRead()));
        var length = await files[i].length();
        var multipartFile = new http.MultipartFile(fileKey[i], stream, length,
            filename: basename(files[i].path));

        print(
            "Header FIle   ${multipartFile.field} ,  ${multipartFile.filename} ,  ${multipartFile.length}");

        request.files.add(multipartFile);
      }
    }

    if (headerRequired) {
      request.headers.addAll(header_for_file_upload);
    }

    var response = await request.send();

    print("The Response : ${response}");
    await response.stream.transform(utf8.decoder).listen((value) {
      result = value;
      print(result);
    });
    showData(url: url, body: body, method: method, response: result.toString());
    return json.decode(result);
  }

  static void showData(
      {required String url, var body, String? response, Method? method, var header}) {
    if (!kReleaseMode) {
      //print("Header = $header");
      print("URL = $url");
      print("Body = $body");
      print("Method = $method");
      print("Header = ${header}");
      print("Response = $response");
    }
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AuthController.to.token}'
  };

  static Map<String, String> header_for_file_upload = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AuthController.to.token}'
  };
}
