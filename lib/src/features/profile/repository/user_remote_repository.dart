import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../core/Error/failures.dart';
import '../../../core/Network/network_info.dart';
import '../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../core/remote/urls/app_urls.dart';
import '../domain/model/User.dart';

class UserRemoteRepository {
  Future<Either<Failure, http.Response>?>? getUser() async {
    print("Url : =>  ${ApiUrls.userProfile}");
    try {
      //if (await NetworkInfoController.to.isConnected) {
      print("Url : =>  ${ApiUrls.userProfile}");
      var response = await ApiClient.Request(
          url: "${ApiUrls.userProfile}", enableHeader: true);
      return Right(response!);
      /*} else {
       */
      return Left(NoConnectionFailure());
    } catch (err) {
      printError(info: err.toString());

      return Left(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> updateUserProfile({
    User? user,
    File? file,
    String? imageKey,
  }) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        dynamic response = await ApiClient.RequestWithFile(
            files: file != null ? [file] : [],
            fileKey: file != null ? [imageKey ?? ""] : [],
            url: ApiUrls.userProfileUpdate,
            body: user?.toJson() ?? {},
            headerRequired: true,
            method: Method.POST);
        print("Response : ${response}");

        /*       var request =
            http.MultipartRequest("POST", Uri.parse(ApiUrls.userProfileUpdate));

        request.headers.addAll({
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AppConstantData.token}'
        });
        request.fields.addAll(user.toJson());
        request.files.add(http.MultipartFile(
            'photo', file.readAsBytes().asStream(), file.lengthSync(),
            filename: file.path));

        var res = await request.send();

        await res.stream.transform(utf8.decoder).listen((value) {
          result = value;
          print("RESPONSE ============> ${result}");
        });*/

        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error r: ${err}");
      return Right(ServerFailure());
    }
  }

  Future<Either<dynamic, Failure>> updateNewPassword(body) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("Url : =>  ${ApiUrls.userProfile}");
        var response = await ApiClient.Request(
            method: Method.POST,
            body: body,
            url: "${ApiUrls.changePassword}",
            enableHeader: true);
        return Left(response);
      } else {
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Right(ServerFailure());
    }
  }
}
