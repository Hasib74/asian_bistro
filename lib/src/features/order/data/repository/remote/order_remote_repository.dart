import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/Error/failures.dart';
import '../../../../../core/Network/network_info.dart';
import '../../../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../../../core/remote/urls/app_urls.dart';

class OrderRemoteRepository {

  Future<Either<dynamic, Failure>> order(body) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("SUB BODY ${body}");
        dynamic response = await ApiClient.Request(
            url: ApiUrls.order,
            enableHeader: true,
            body: body,
            method: Method.POST);

        printInfo(info: "Order Response ::: ${response}");
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
}
