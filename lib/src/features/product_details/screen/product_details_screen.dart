import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_cart_bardge_widget.dart';

import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/all_products/data/domain/model/product_model.dart';
import 'package:pizza_user_app/src/features/product_details/controller/product_details_controller.dart';
import 'package:pizza_user_app/src/features/product_details/model/extra_items_response_model.dart';
import 'package:pizza_user_app/src/features/product_details/screen/sections/choose_size.dart';
import 'package:pizza_user_app/src/features/product_details/screen/sections/extra_items.dart';

import '../../../core/data/local_data/model/favourite_model.dart';
import '../../cart/controller/CartController.dart';

import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductNames productNames;
  String? productId;
  String? productImage;

  String? productName;

  String? productPrice;

  String? productDescription;

  String? productCategory;

  String? productRating;

  String? productDiscount;

  String? productDiscountPrice;

  String? productQuantity;

  String? productUnit;

  String? productUnitPrice;

  String? productUnitQuantity;

  String? productUnitDiscount;

  String? productUnitDiscountPrice;

  String? productUnitTotalPrice;

  String? productTotalPrice;

  String? productTotalDiscount;

  String? productTotalDiscountPrice;

  ProductDetailsScreen({
    Key? key,
    required this.productNames,
    this.productName,
    this.productImage,
    this.productId,
    this.productPrice,
    this.productDescription,
    this.productCategory,
    this.productRating,
    this.productDiscount,
    this.productDiscountPrice,
    this.productQuantity,
    this.productUnit,
    this.productUnitPrice,
    this.productUnitQuantity,
    this.productUnitDiscount,
    this.productUnitDiscountPrice,
    this.productUnitTotalPrice,
    this.productTotalPrice,
    this.productTotalDiscount,
    this.productTotalDiscountPrice,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<bool> isFav() async => await FavoriteProduct()
      .isFavorite(int.parse(widget.productId.toString()));

  int? sizeId;
  var sizePrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    printInfo(info: "ProductDetailsScreen initState .... ");
    if (!Get.isRegistered<ProductDetailsController>()) {
      Get.put(ProductDetailsController());
    }

    Future.delayed(Duration.zero).then((value) async {
      await ProductDetailsController.to.getProductExtraItems(widget.productId);

      await ProductDetailsController.to.getProductSize(widget.productId);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print("ProductDetailsScreen dispose ...");

    ProductDetailsController.to.selectedSize.close();
    ProductDetailsController.to.selectedExtraItems.close();
  }

  @override
  void didUpdateWidget(covariant ProductDetailsScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("ProductDetailsScreen didUpdateWidget .... ");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    print("ProductDetailsScreen didChangeDependencies ...");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    print("ProductDetailsScreen deactivate ...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          child: Column(
            children: [
              _top(),
              _image(),
              _body(),
              _addToCart(),
            ],
          ),
        ),
      ),
    );
  }

  Container _image() {
    //print("ApiUrls.download_base_url + widget.productImage! ::: ${ApiUrls.download_base_url + widget.productImage!}");
    return Container(
      width: Get.width,
      height: 300,
      child: Image.network(
        widget.productImage == null || widget.productImage!.isEmpty
            ? ApiUrls.demoImage
            : widget.productImage!.contains("http")
                ? widget.productImage!
                : ApiUrls.download_base_url + widget.productImage!,
        fit: BoxFit.contain,
      ),
    );
  }

  Row _top() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: _favourite(),
        ),
        AppCartBardeWidget(
          iconColor: AppColors.blackColor,
     /*     onBack: () {
            ProductDetailsController.to
                .setIntialSelectedExtraItemsAndSize(widget.productId);
            setState(() {});

            printInfo(info: "After back from cart screen");
          },*/
        ),
        AppSpaces.spaces_width_15
      ],
    );
  }

  _favourite() {
    return FutureBuilder(
      future: isFav(),
      builder: (context, snapshot) {
        return IconButton(
          onPressed: () async {
            if (snapshot.data == true) {
              FavoriteProduct().deleteFavoriteProduct(
                  int.parse(widget.productId.toString()));
              setState(() {});

              //widget.onRemove != null ? widget.onRemove!() : Container;
            } else {
              await FavoriteProduct().insertFavoriteProduct(FavoriteProduct(
                id: int.parse(widget.productId.toString()),
                name: widget.productName,
                image: widget.productImage,
                price: widget.productPrice,
                description: widget.productDescription,
                discount: widget.productDiscount.toString(),
                rating: widget.productRating.toString(),
                //   productType: widget.productNames,
              ));

              setState(() {});
            }
          },
          icon: Container(
            // decoration: BoxDecoration(
            //   color: AppColors.primaryColor,
            //   borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(5),
            //       bottomLeft: Radius.circular(5),
            //       bottomRight: Radius.circular(0)),
            // ),
            height: 40,
            width: 40,
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                snapshot.data == true ? Icons.favorite : Icons.favorite_border,
                color: AppColors.blackColor,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }

  _addToCart() {
    /* var cart = CartController.to.cartLst
        .where((p0) =>
            p0.productNames?.product_name_id ==
            widget.productId.toString())
        .first;

    ProductDetailsController.to.selectedExtraItems.value =
        cart.productNames?.extraItems == null
            ? []
            : cart.productNames!.extraItems!
                .map((e) => ProductExtraItem(
                    id: num.parse(e.extraItemId.toString()),
                    name: e.extraItemName,
                    price: e.extraItemPrice,
                    image: e.extraItemImage))
                .toList();*/

    /**/
    bool? _isAlreadyAdded = CartController.to.isAlreadyHaveIntoCartV2(
        widget.productNames.product_name_id.toString());

    if (_isAlreadyAdded != null && _isAlreadyAdded) {
      return Text("Already Added to Cart");
    } else {
      return Container(
        width: Get.width,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              /*  BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, -1))*/
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: _isAlreadyAdded != null && _isAlreadyAdded
            ? Center(
                child: Text("Already Added to Cart"),
              )
            : InkWell(
                onTap: () async {
                  bool _isAlreadyAdded =
                      await CartController.to.isAlreadyAddedToCart(ProductNames(
                    price: widget.productPrice,
                    productName: widget.productName,
                    imagePath: widget.productImage,
                    product_name_id: int.parse(widget.productId.toString()),
                    isActive: 1,
                    productSize: sizeId,
                    sizePrice: sizePrice,
                  ));

                  if (_isAlreadyAdded) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      title: 'Warning',
                      desc: 'Product already added to cart',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                      btnOk: Container(),
                      btnCancel: Container(),
                    ).show();

                    setState(() {});
                  } else {
                    // await CartController.to.addToCart(
                    //     productNames: ProductNames(
                    //   price: widget.productPrice,
                    //   productName: widget.productName,
                    //   imagePath: widget.productImage,
                    //   product_name_id: int.parse(widget.productId.toString()),
                    //   isActive: 1,
                    // ));

                    List<ExtraItemsModel> extraItems = [];

                    // CartController.to.removeAllExtraItems(widget.productNames.product_name_id);

                    if (ProductDetailsController
                        .to.selectedExtraItems.isNotEmpty) {
                      ProductDetailsController.to.selectedExtraItems
                          .forEach((element) {
                        extraItems.add(ExtraItemsModel(
                          extraItemId: element.id.toString(),
                          extraItemPrice: element.price,
                          extraItemName: element.name,
                          extraItemImage: element.image,
                        ));
                      });
                    }

                    widget.productNames.extraItems = extraItems;

                    if (sizeId != null) {
                      widget.productNames.productSize = sizeId ?? null;
                      widget.productNames.sizeName = sizeId == null
                          ? null
                          : ProductDetailsController.to.selectedSize.value?.name
                              .toString();
                    }

                    widget.productNames.totalExtraItems =
                        ProductDetailsController.to.extraItemsResponseModel
                            .value.data?[0].productExtraItem;

                    if (ProductDetailsController
                            .to.productSizeResponseModel.value.data !=
                        null) {
                      if (sizeId != null) {
                        widget.productNames.totalProductSizeList =
                            ProductDetailsController.to.productSizeResponseModel
                                .value.data?[0].productSize;
                      }
                    }

                    printInfo(
                        info:
                            "Adding extra items  before ${widget.productNames.extraItems}");

                    CartController.to.addToCart(
                      productNames: widget.productNames,
                      count: 1,
                      price: _price(),
                      /*: (double.parse(0
                                                                .toString()) /
                                                            100) *
                                                        double.parse(
                                                            _productName.price.toString())*/
                    );

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.bottomSlide,
                      title: 'Success',
                      desc: 'Product added to cart successfully',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                      btnOk: Container(),
                      btnCancel: Container(),
                    ).show();

                    setState(() {});
                  }
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 20,
                      child: Container(
                        width: Get.width,
                        //height: 120,
                        decoration: BoxDecoration(
                            color: Color(0xffF9F9F9),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, -1))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 40,
                      child: _addToCartIcon(),
                    )
                  ],
                ),
              ),
      );
    }
  }

  Column _addToCartIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xffF9F9F9), blurRadius: 5, spreadRadius: 1)
              ],
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Icon(
              Icons.shopping_cart,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        AppSpaces.spaces_height_5,
        Text(
          "Add to cart",
          style: Get.textTheme.titleSmall,
        ),
      ],
    );
  }

  _body() {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.productName ?? "",
              style: Get.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${widget.productPrice!}",
                  style: Get.textTheme.titleLarge,
                )
              ],
            ),
          ),
          AppSpaces.spaces_height_10,
          ChooseSize(
            id: widget.productId,
            onSelectedSize: (int id, dynamic price) {
              sizeId = id;

              sizePrice = price;

              printInfo(info: "On selected size : ${id}");
            },
          ),
          AppSpaces.spaces_height_10,
          ExtraItems(
            onSelectedProductExtraItems: (value) {
              print("Selected Extra Items :: ${value}");

              if (value.isNotEmpty) {}

              ProductDetailsController.to.selectedExtraItems.value = value;
            },
          ),
          AppSpaces.spaces_height_10,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.productDescription ?? "",
              style: Get.textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
          ),
          AppSpaces.spaces_height_5,
          AppSpaces.spaces_height_5
        ],
      ),
    );
  }

  _price() {
    double _price = 0.0;

    if (sizePrice != null) {



      _price = double.parse(sizePrice.toString());
    } else {
      _price = double.parse(widget.productPrice.toString());
    }

    return _price;
  }
}
