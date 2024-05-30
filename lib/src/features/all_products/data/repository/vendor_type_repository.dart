import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pizza_user_app/src/features/all_products/data/repository/vendor_type_remote_reposiotry.dart';

import '../../../../core/Error/failures.dart';
import '../domain/model/product_model.dart';
import 'package:http/http.dart' as http;

class VendorTypeRepository {
  VendorTypeRemoteRepository _vendorTypeRemoteRepository =
      new VendorTypeRemoteRepository();

  Future<Either<Failure, ProductType?>> getProductType(index) async {
/*    Either<Failure, dynamic> data =
        await _vendorTypeLocalRepository.getProductType();*/

    /* if (data.isRight() */ /*&& data.getOrElse(() => null) != null*/ /*) {
      ProductType d =
          ProductType.fromJson(jsonDecode(data.getOrElse(() => null)));
      return Right(d);
    } else {*/
    Either<Failure, http.Response?> data =
        await _vendorTypeRemoteRepository.getVendorType(index);

    //check right data is not null

    if (data.isRight()) {
      http.Response? response = data.getOrElse(() => null);

      if (response == null) {
        return Left(ServerFailure());
      }

      ProductType? vendorOffer = ProductType.fromJson(jsonDecode(
          data.getOrElse(() => throw UnimplementedError())?.body ?? ""));
      //_vendorOfferLocalRepository.setVendorOffer(jsonEncode(vendorOffer));
      return Right(vendorOffer);
    } else {
      return Left(data.foldLeft(
          NoConnectionFailure(), (previous, r) => ServerFailure()));
    }
/*    }*/
  }
}
