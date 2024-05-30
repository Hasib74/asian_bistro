import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../core/Error/failures.dart';
import '../../../core/Network/network_info.dart';
import '../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../core/remote/urls/app_urls.dart';


NetworkInfoController _networkInfoController = Get.find();

class AuthenticationRemoteRepository {
  Future<Either<dynamic, Failure>> signUp(body) async {
    try {
      if (await _networkInfoController.isConnected) {
        print("SUB BODY ${body}");
        dynamic response = await ApiClient.Request(
            url: ApiUrls.user_signup,
            enableHeader: false,
            body: body,
            method: Method.POST);

        return Left(response);
      } else {
        // return Left(ServerFailure());
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      //  print("SUB BODY ${vendorModel.toJson()}");
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> signIn(body) async {
    try {
      if (await _networkInfoController.isConnected) {
        print("SUB BODY ${body}");
        dynamic response = await ApiClient.Request(
            url: ApiUrls.user_signIN,
            enableHeader: false,
            body: body,
            method: Method.POST);

        return Left(response);
      } else {
        // return Left(ServerFailure());
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      //  print("SUB BODY ${vendorModel.toJson()}");
      print("Error : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<http.Response, Failure>> sendAccountRecoveryPassword(
      String phoneNo) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("Sub body Account Recovery ${phoneNo}");
        dynamic response = await ApiClient.Request(
            url: "${ApiUrls.account_recovery}",
            enableHeader: false,
            body: {'phone': phoneNo},
            method: Method.POST);
        return Left(response);
      } else {
        print("Network error.........");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error.......................... : ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<http.Response, Failure>> logOut() async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        dynamic response = await ApiClient.Request(
          url: "${ApiUrls.logOut}",
          enableHeader: true,
          method: Method.POST,
        );
        return Left(response);
      } else {
        print("Network error.........");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error.......................... : ${err}");
      return Right(ServerFailure());
    }
  }
}
