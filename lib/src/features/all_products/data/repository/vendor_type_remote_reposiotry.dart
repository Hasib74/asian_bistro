
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/Error/failures.dart';
import '../../../../core/Network/network_info.dart';
import '../../../../core/remote/app_helper/app_remote_helper.dart';
import '../../../../core/remote/urls/app_urls.dart';
class VendorTypeRemoteRepository {
  Future<Either<Failure, http.Response?>> getVendorType(index) async {
    try {
      if (await NetworkInfoController.to.isConnected) {
        print("Url : =>  ${ApiUrls.vendor_type}/$index");
        var response = await ApiClient.Request(
          url: "${ApiUrls.vendor_type}/$index",
        );
        return Right(response??null);
      } else {
        return Left(NoConnectionFailure());
      }
    } catch (err) {
      printError(info: err.toString());

      return Left(ServerFailure());
    }
  }
}
