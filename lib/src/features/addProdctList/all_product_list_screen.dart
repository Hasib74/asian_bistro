import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_cart_bardge_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_loading.dart';
import 'package:pizza_user_app/src/core/common_widgets/product_card.dart';
import 'package:pizza_user_app/src/features/addProdctList/controller/all_product_list_controller.dart';
import 'package:pizza_user_app/src/features/all_products/data/domain/model/product_model.dart';

import '../../core/remote/urls/app_urls.dart';
import '../../core/utils/colors/app_colors.dart';
import '../all_products/controller/ProductListController.dart';
import '../cart/controller/CartController.dart';
import 'model/all_product_list_model.dart';

class AllProductListScreen extends StatelessWidget {
  const AllProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Product List"),
          backgroundColor: AppColors.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppCartBardeWidget(),
            )
          ],
        ),
        body: FutureBuilder(
          future: AllProductListController().getAllProductList(),
          builder: (BuildContext context,
              AsyncSnapshot<AllProductListModel?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("none");
              case ConnectionState.waiting:
                return Center(child: AppLoading());
              case ConnectionState.active:
                return Text("active");
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text("error");
                } else {
                  print("All Product List ${snapshot.data?.response?.length}");
                  return ListView.builder(
                    itemCount: snapshot.data?.response?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: snapshot.data?.response?[index].productName ?? "",
                        price: snapshot.data?.response?[index].price ?? "",
                        image: snapshot.data?.response?[index].imagePath != null
                            ? ApiUrls.download_base_url +
                                snapshot.data!.response![index].imagePath!
                            : "",
                        description:
                            snapshot.data?.response?[index].description ?? "",
                        id: snapshot.data?.response?[index].productNameId ?? "",
                        productNames: ProductNames(
                          productName:
                              snapshot.data?.response?[index].productName ?? "",
                          product_name_id: snapshot
                              .data?.response?[index].productNameId
                              ,
                          productTypeId: snapshot
                              .data?.response?[index].productTypeId

                              ,
                          price: snapshot.data?.response?[index].price ?? "",
                          imagePath: snapshot.data?.response?[index].imagePath,
                          description:
                              snapshot.data?.response?[index].description ?? "",
                        ),
                        cartOnTap: () async {
                          bool isAvilable = await ProductListController.to
                              .productStock(snapshot
                                  .data?.response?[index].productNameId);

                          if (isAvilable) {
                            /*  print(
                        "Amount ============>  ${(double.parse(_vendor.offer
                            .amount.toString()) / 100) *
                            double.parse(_productName.price.toString())}");*/
                            CartController.to.addToCart(
                                productNames: ProductNames(
                                    productName: snapshot.data?.response?[index].productName ??
                                        "",
                                    product_name_id: snapshot
                                        .data?.response?[index].productNameId
                                        ,
                                    productTypeId: snapshot
                                        .data?.response?[index].productTypeId
                                        ,
                                    imagePath: snapshot
                                        .data?.response?[index].imagePath,
                                    description: snapshot.data?.response?[index].description ??
                                        ""),
                                count: 1,
                                price: snapshot.data?.response?[index].offerAmount == null
                                    ? snapshot.data?.response![index].price
                                    : double.parse(snapshot.data!.response![index].price.toString()) -
                                        (double.parse(snapshot.data!.response![index].price.toString()) *
                                            (double.parse(snapshot.data!.response![index].offerAmount.toString()) / 100))
                                /*: (double.parse(0
                                                            .toString()) /
                                                        100) *
                                                    double.parse(
                                                        _productName.price.toString())*/
                                );
                          }
                        },
                      );
                    },
                  );
                }
            }
          },
        ));
  }
}
