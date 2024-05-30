import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import 'package:get/get_connect.dart';

import '../../../../core/Error/failures.dart';
import '../../../../core/Network/network_info.dart';
import '../../../../core/remote/urls/app_urls.dart';

class StockRepository extends GetConnect {
  Future<Either<Failure, Response>> productStock(var productId) async {
    if (await NetworkInfoController.to.isConnected) {
      printInfo(info: "productStock   ${productId}");

      print("Url ===> ${ApiUrls.product_stock}/${productId}");
      Response response = await get(
        "${ApiUrls.product_stock}/${productId}",
      );

      printInfo(info: "Response =======> ${response.body}");
      return Right(response);
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
