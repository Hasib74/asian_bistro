import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/routing/app_routes.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/common_widgets/app_grid_product_view.dart';
import '../../../../core/common_widgets/app_image_view_widget.dart';
import '../../../../core/remote/urls/app_urls.dart';
import '../../../../core/utils/spaces/AppSpaces.dart';
import '../../../all_products/data/domain/model/product_model.dart';
import '../../../product_details/screen/product_details_screen.dart';
import '../../controller/app_home_controller.dart';
import '../../model/offer_product_model.dart';

class AppSpecialProducts extends StatelessWidget {
  const AppSpecialProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("AppSpecialProducts");
    return _body();
  }

  _body() {
    return FutureBuilder(
        future: AppHomeController.to.getWinterOfferProduct(),
        builder:
            (context, AsyncSnapshot<OfferProductModel?> offerProductModel) {


          print("offerProductModel ${offerProductModel.data?.response}");
          if (offerProductModel.hasData) {


            print("offerProductModel ${offerProductModel.data?.response}");
            if (offerProductModel.data == null ||
                offerProductModel.data!.response!.isEmpty) {
              return Container();
            }

            var _data = offerProductModel.data?.response;

            return Column(
              children: [
                Text(
                  "WINTER SPECIAL OFFER",
                  style: Get.textTheme.titleLarge?.copyWith(
                      color: Colors.red, fontWeight: FontWeight.w800),
                ),
                Text(
                  "DEAL OF THE DAY",
                  style: Get.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                AppSpaces.spaces_height_10,
                AppImageView(
                        image: Assets.imagesLine,
                        width: Get.width * 0.9,
                        height: 20)
                    .getImage(),
                Container(
                  height: 290,
                  width: Get.width,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      itemBuilder: (context, int index) {
                        return AppGridProductView.newDesign(
                          imageUrl: _data?[index].imagePath != null
                              ? ApiUrls.download_base_url +
                                  _data![index].imagePath!
                              : null,
                          productName:
                              _data?[index].productName.toString() ?? "",
                          productPrice: _data?[index].price.toString() ?? "",
                          productDescription:
                              _data?[index].description.toString() ?? "",
                          onTab: () async {
                            Get.to(() => ProductDetailsScreen(
                                  productId:
                                      _data?[index].productNameId.toString(),
                                  productName:
                                      _data?[index].productName.toString(),
                                  productImage:
                                      _data?[index].imagePath.toString(),
                                  productPrice: _data?[index].price.toString(),
                                  productDescription:
                                      _data?[index].description.toString(),
                                  productRating: 0.toString(),
                                  productCategory:
                                      _data?[index].productTypeId.toString(),
                                  productNames: ProductNames(
                                    product_name_id:
                                        _data?[index].productNameId,
                                    productTypeId:
                                        _data?[index].productTypeId,
                                    imagePath:
                                        _data?[index].imagePath.toString(),
                                    productName:
                                        _data?[index].productName.toString(),
                                    price: _data?[index].price.toString(),
                                    description:
                                        _data?[index].description.toString(),

                                    // productTypeId: _data![index].productTypeId.toString(),
                                  ),
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, int index) {
                        return AppSpaces.spaces_width_15;
                      },
                      itemCount: _data != null ? _data.length : 0),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
