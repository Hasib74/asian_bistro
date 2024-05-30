import 'package:dartz/dartz.dart';
import 'package:pizza_user_app/src/features/OrderTracking/data/OrderTrackingRemoteRepository.dart';

import '../../../core/Error/failures.dart';


class OrderTrackingRepository {
  OrderTrackingRemoteRepository _orderTrackingRemoteRepository =
      new OrderTrackingRemoteRepository();

  Future<Either<dynamic, Failure>?> orderTracking() async {
    Either<dynamic, Failure>? response;
    var either = await _orderTrackingRemoteRepository.orderTracking();

    Either<dynamic, Failure> userResponse = either;
    userResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });

    return response;
  }


  Future<Either<dynamic, Failure>> orderDetailsProductList(int orderId) async {

   // Either<dynamic, Failure> _response ;

    Either<dynamic, Failure> response = await _orderTrackingRemoteRepository.getOrderDetailsProductList(orderId);

    //  Either<dynamic, Failure> userResponse = either;
    response.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });


    return response;
  }

}
