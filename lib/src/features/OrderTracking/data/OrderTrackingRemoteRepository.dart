import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/Error/failures.dart';
import '../../../core/Network/network_info.dart';
import '../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../core/remote/urls/app_urls.dart';


class OrderTrackingRemoteRepository {
  NetworkInfoController _networkInfoController = Get.find();

  Future<Either<dynamic, Failure>> orderTracking() async {
    try {
      if (await _networkInfoController.isConnected) {
        //   print("SUB BODY ${body}");
        dynamic response = await ApiClient.Request(
            url: ApiUrls.orderTracking, enableHeader: true, method: Method.GET);
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

  Future<Either<dynamic, Failure>> getOrderDetailsProductList(
      int orderId) async {
    try {
      /* Map<String, dynamic> bodyData = {
        "id": orderId,
      };*/
      if (await _networkInfoController.isConnected) {
        printInfo(
            info:
                "Order details : URL : ${ApiUrls.getOrderProductList + "${orderId}"}");
        var response = await ApiClient.Request(
            url: ApiUrls.getOrderProductList + "${orderId}",
            enableHeader: true,
            method: Method.GET);
        /*  printInfo(
            info:
                "Order details New Order details productlist Response ::: ${response}");*/
        return Left(response);
      } else {
        print("Order details Noooooooooo Network");
        return Right(NoConnectionFailure());
      }
    } catch (err) {
      print("Error : ${err} ");
      return Right(ServerFailure());
    }
  }
}
