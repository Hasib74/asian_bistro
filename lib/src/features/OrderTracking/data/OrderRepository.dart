import 'package:dartz/dartz.dart';

import '../../../core/Error/failures.dart';
import '../../order/data/repository/remote/order_remote_repository.dart';


class OrderRepository {
  OrderRemoteRepository _orderRemoteRepository = new OrderRemoteRepository();

  Future<Either<dynamic, Failure>?> order(body) async {
    Either<dynamic, Failure>? response;
    var either = await _orderRemoteRepository.order(body);

    Either<dynamic, Failure> userResponse = either;
    userResponse.fold((l) {
      response = Left(l);
    }, (r) {
      response = Right(r);
    });

    return response;
  }
}
