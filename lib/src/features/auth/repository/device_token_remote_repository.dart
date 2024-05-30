import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../core/remote/urls/app_urls.dart';
import '../controller/auth_controller.dart';
import 'device_token_repository.dart';
import 'package:http/http.dart' as http;

class DeviceTokenRemoteRepository extends DeviceTokenRepository {
  String _TAG = "_DeviceTokenRemoteRepository";

  @override
  saveDeviceToken(String deviceToken, String id) async {
    // TODO: implement saveDeviceToken
    //  throw UnimplementedError()
    try {
      Map<String, dynamic> _body = {"id": id, "device_token": deviceToken};
      var _header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthController.to.token}'
      };
      var _response = await http.post(Uri.parse(ApiUrls.updateDeviceToken),
          body: jsonEncode(_body), headers: _header);

      print("${_TAG} url : ${ApiUrls.updateDeviceToken}");

      print("${_TAG} Device info Response : ${_response.body}");
      print("${_TAG} header : ${_header}");
      //print("${_TAG} url : ${ApiUrls.updateDeviceToken}") ;
    } on Exception catch (e) {
      // TODO
      print("${_TAG} error : ${e.toString()}");
    }
  }

  @override
  Future<String> getDeviceToken() {
    // TODO: implement getDeviceToken

    Completer<String> deviceToken = Completer();

    if (Platform.isIOS) {
      FirebaseMessaging.instance.getAPNSToken().then((value) {
        deviceToken.complete(value);
      });
    } else {
      FirebaseMessaging.instance.getToken().then((value) {
        deviceToken.complete(value);
      });
    }

    return deviceToken.future;
  }
}
