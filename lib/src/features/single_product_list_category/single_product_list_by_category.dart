import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';

import '../../../generated/assets.dart';
import '../../core/common_widgets/app_icon_button.dart';
import '../../core/common_widgets/app_loading.dart';
import '../../core/remote/urls/app_urls.dart';
import '../../core/routing/app_routes.dart';
import '../all_products/controller/ProductListController.dart';
import 'package:get/get.dart';

import '../all_products/data/domain/model/product_model.dart';
import '../../core/common_widgets/product_card.dart';
import '../cart/controller/CartController.dart';
import '../cart/screen/cart_screen.dart';

class SingleProductListByCategory extends StatefulWidget {
  SingleProductListByCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleProductListByCategory> createState() =>
      _SingleProductListByCategoryState();
}

class _SingleProductListByCategoryState
    extends State<SingleProductListByCategory> {
  String? category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      category = Get.arguments;
      print("Category is $category");

      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          category ?? "",
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: Obx(() {
                return /*CartController.to.cartLst.isEmpty
                    ? Container(
                        color: Colors.transparent,
                      )
                    : */
                    Text(
                  "${CartController.to.cartLst.length > 10 ? "9+" : CartController.to.cartLst.length}",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              offset: Offset(-4, -4),
              child: AppIconButton(
                image: Assets.imagesCart,
                index: 4,
                onPressed: () {
                  Get.to(() => CartScreen(
                        enableAppBar: true,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: _products()),
    );
  }

  _products() {
    return Obx(() {
      print(
          "ProductListController.to.vendorType.value.message is ${ProductListController.to.vendorType.value.message}");
      return ProductListController.to.vendorType.value.message == null
          ? Center(child: AppLoading())
          : ProductListController.to.vendorType.value.message != null
              ? ProductListController.to.vendorType.value.message!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16 * 10, top: 16),
                      itemBuilder: (context, int index) {
                        print(
                            "Product name is ${ProductListController.to.vendorType.value.message?.firstWhere((element) => element.productTypeName?.endsWith(category ?? "") ?? false).productNames?[index].productName}");

                        ProductNames _productName = ProductListController
                                .to.vendorType.value.message
                                ?.firstWhere((element) =>
                                    element.productTypeName
                                        ?.endsWith(category ?? "") ??
                                    false)
                                .productNames?[index] ??
                            ProductNames();

                        printInfo(
                            info: "Products is ${_productName.productName}");

                        printInfo(info: "Products price ${_productName.price}");

                        return ProductCard(
                          id: _productName.product_name_id,
                          key: Key(_productName.product_name_id.toString()),
                          productNames: _productName,

                          cartOnTap: () async {
                            bool isAvilable = await ProductListController.to
                                .productStock(_productName.product_name_id);

                            if (isAvilable) {
                              /*  print(
                        "Amount ============>  ${(double.parse(_vendor.offer
                            .amount.toString()) / 100) *
                            double.parse(_productName.price.toString())}");*/
                              CartController.to.addToCart(
                                  productNames: _productName,
                                  count: 1,
                                  price: _productName.offer_amount == null
                                      ? _productName.price
                                      : double.parse(
                                              _productName.price.toString()) -
                                          (double.parse(_productName.price
                                                  .toString()) *
                                              (double.parse(_productName
                                                      .offer_amount
                                                      .toString()) /
                                                  100))
                                  /*: (double.parse(0
                                                            .toString()) /
                                                        100) *
                                                    double.parse(
                                                        _productName.price.toString())*/
                                  );
                            }
                          },
                          name: _productName.productName,
                          description: _productName.description,
                          offer: _productName.offer_amount ?? 0,
                          price: double.parse(_productName.price)
                                  .toStringAsFixed(2) ??
                              "0.0",
                          image: _productName.imagePath != null
                              ? ApiUrls.download_base_url +
                                  _productName.imagePath
                              : "",

                          //rating: _productName., // Rating Missing .
                        );
                      },
                      separatorBuilder: (context, int index) {
                        return Container(
                          height: 5,
                        );
                      },
                      itemCount: ProductListController
                              .to.vendorType.value.message
                              ?.firstWhere((element) =>
                                  element.productTypeName
                                      ?.endsWith(category ?? "") ??
                                  false)
                              .productNames
                              ?.length ??
                          0)
                  : Center(
                      child: Center(
                        child: Text("Product not available"),
                      ),
                    )
              : Center(
                  child: Text("Loading..."),
                );
    });
  }
}
