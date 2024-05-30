import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_cart_bardge_widget.dart';

import '../../../core/common_widgets/app_loading.dart';
import '../../../core/common_widgets/app_search_bar.dart';
import '../../../core/remote/urls/app_urls.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/spaces/AppSpaces.dart';
import '../../cart/binding/app_cart_binding.dart';
import '../../cart/controller/CartController.dart';
import '../binding/all_product_controller_bindings.dart';
import '../controller/ProductListController.dart';
import '../data/domain/model/product_model.dart';
import '../../../core/common_widgets/product_card.dart';

class ProductList extends StatefulWidget {
  bool? forSearch = false;

  ProductList({Key? key, this.forSearch}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with TickerProviderStateMixin {
  // Vendor _vendor = Get.arguments;

  FocusNode? _focusNode;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    AllProductsControllerBindings().dependencies();
    CartControllerBinding().dependencies();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode = FocusNode();
      if (widget.forSearch == true) {
        _focusNode?.requestFocus();
      }
      ProductListController.to.getVendorType(1);

      ProductListController.to.selectedIndex.value = -1;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ProductListController.to.setSelectedIndex(0);
    _focusNode?.unfocus();
    _focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.forSearch == true
          ? AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text("Search Product"),
              actions: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppCartBardeWidget()),
              ],
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            //    _productType(_productListController),

            AppSearchWidget(
              focusNode: _focusNode,
              searchTextExitingController:
                  ProductListController.to.searchTextEditingController,
              searchText: (String? value) {
                printInfo(info: "Serach output... ${value}");
                ProductListController.to.searchProductList(value ?? "");
              },
              closeBtnOnClick: () {
                ProductListController.to.searchTextEditingController.clear();
                ProductListController.to.searchText.value = "";
                ProductListController.to.searchProductsName.clear();
                ProductListController.to.searchProductsName.refresh();
              },
            ),
            AppSpaces.spaces_height_10,
            _body()
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Obx(() {
      if (ProductListController.to.searchProductsName.isEmpty &&
          ProductListController.to.searchText.isEmpty) {
        if (widget.forSearch == true) {
          return const Expanded(
            child: Center(
              child: Text("Search Product"),
            ),
          );
        }
        return Expanded(
          child: Column(
            children: [
              __productType(),
              Divider(),
              Obx(() {
                if (ProductListController.to.selectedIndex.value == -1) {
                  List<ProductNames> allProducts = [];

                  ProductListController.to.vendorType.value.message
                      ?.forEach((element) {
                    allProducts.addAll(element.productNames ?? []);
                  });

                  return Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 16 * 10),
                          itemBuilder: (context, int index) {
                            ProductNames _productName =
                                allProducts[index] ?? ProductNames();

                            printInfo(
                                info:
                                    "Products is ${_productName.productName}");

                            printInfo(
                                info: "Products price ${_productName.price}");

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
                                          : double.parse(_productName.price
                                                  .toString()) -
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
                          itemCount: allProducts.length ?? 0));
                } else {
                  return _products();
                }
              }),
            ],
          ),
        );
      } else {
        return Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                "Search Result : ${ProductListController.to.searchProductsName.length}",
                style: Get.textTheme.bodySmall,
              ),
            ),
            _searchProducts(),
          ],
        ));
      }
    });
  }

  _products() {
    return Obx(() => Expanded(
        child: ProductListController.to.vendorType.value == null
            ? Center(child: AppLoading())
            : ProductListController.to.vendorType.value.message != null
                ? ProductListController.to.vendorType.value.message!.length > 0
                    ? ListView.separated(
                        padding: EdgeInsets.only(bottom: 16 * 10),
                        itemBuilder: (context, int index) {
                          ProductNames _productName = ProductListController
                                  .to
                                  .vendorType
                                  .value
                                  .message?[ProductListController
                                      .to.selectedIndex.value]
                                  .productNames?[index] ??
                              ProductNames();

                          printInfo(
                              info: "Products is ${_productName.productName}");

                          printInfo(
                              info: "Products price ${_productName.price}");

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
                                .to
                                .vendorType
                                .value
                                .message?[ProductListController
                                    .to.selectedIndex.value]
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
                  )));
  }

  _searchProducts() {
    return Obx(() => Expanded(
        child: ProductListController.to.searchProductsName.length > 0
            ? ListView.separated(
                itemBuilder: (context, int index) {
                  ProductNames _productName =
                      ProductListController.to.searchProductsName[index];

                  printInfo(info: "Products is ${_productName.productName}");

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
                                : double.parse(_productName.price.toString()) -
                                    (double.parse(
                                            _productName.price.toString()) *
                                        (double.parse(_productName.offer_amount
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
                    price:
                        double.parse(_productName.price).toStringAsFixed(2) ??
                            "0.0",
                    image: _productName.imagePath != null
                        ? ApiUrls.download_base_url + _productName.imagePath
                        : "",

                    //rating: _productName., // Rating Missing .
                  );
                },
                separatorBuilder: (context, int index) {
                  return Container(
                    height: 5,
                  );
                },
                itemCount: ProductListController.to.searchProductsName.length)
            : Center(
                child: Center(
                  child: Text("Product not available"),
                ),
              )));
  }

  __productType() {
    return Obx(() {
      List<Widget> _list = [];

      if (ProductListController.to.vendorType.value.message != null) {
        _list = ProductListController.to.vendorType.value.message
                ?.map((element) => InkWell(
                      onTap: () => ProductListController.to.setSelectedIndex(
                          ProductListController.to.vendorType.value.message
                                  ?.indexOf(element) ??
                              0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color:
                                ProductListController.to.selectedIndex.value ==
                                        ProductListController
                                            .to.vendorType.value.message
                                            ?.indexOf(element)
                                    ? AppColors.primaryColor
                                    : Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "   ${element.productTypeName}   ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: ProductListController
                                                .to.selectedIndex.value ==
                                            ProductListController
                                                .to.vendorType.value.message
                                                ?.indexOf(element)
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ),
                      ),
                    ))
                .toList() ??
            [];

        _list.insert(
            0,
            InkWell(
              onTap: () {
                ProductListController.to.selectedIndex.value = -1;
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: ProductListController.to.selectedIndex.value == -1
                        ? AppColors.primaryColor
                        : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "   All Items   ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            ProductListController.to.selectedIndex.value == -1
                                ? Colors.white
                                : Colors.black),
                  ),
                ),
              ),
            ));
      }

      return ProductListController.to.vendorType.value.message == null
          ? Container()
          : Container(
              width: Get.width,
              height: 35,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: _list ?? [],
              ),
            );
    });
  }
}
