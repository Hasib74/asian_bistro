import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_cart_bardge_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widgets.dart';
import 'package:pizza_user_app/src/core/remote/urls/app_urls.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/core/utils/spaces/AppSpaces.dart';
import 'package:pizza_user_app/src/features/all_products/data/domain/model/product_model.dart';

import '../../../core/data/local_data/model/favourite_model.dart';
import '../../cart/controller/CartController.dart';

String _productDetails =
    '''Margherita Pizza: A classic pizza with a thin crust topped with tomato sauce, mozzarella cheese, and fresh basil leaves.

1. Pepperoni Pizza: A popular choice, featuring a thin or thick crust topped with tomato sauce, mozzarella cheese, and slices of pepperoni, a type of spicy cured sausage.

2. Hawaiian Pizza: Controversial but loved by many, this pizza includes a thin or thick crust topped with tomato sauce, mozzarella cheese, ham, and pineapple chunks.

3. Vegetarian Pizza: A pizza that caters to vegetarians, typically with a thin or thick crust topped with tomato sauce, mozzarella cheese, and a variety of vegetables such as bell peppers, mushrooms, onions, olives, and tomatoes.

4. BBQ Chicken Pizza: A unique twist on pizza, featuring a crust topped with barbecue sauce, mozzarella cheese, diced or shredded chicken, red onions, and sometimes additional ingredients like bacon or cilantro.

5. Four Cheese Pizza: A cheesy delight with a thin or thick crust topped with a combination of different cheeses such as mozzarella, cheddar, Parmesan, and Gouda.

6. Supreme Pizza: A loaded pizza with a variety of toppings including pepperoni, sausage, bell peppers, onions, olives, mushrooms, and sometimes additional ingredients like ham or bacon.

7. Gluten-Free Pizza: An option for individuals with gluten sensitivities or celiac disease, made with a crust that is free from wheat flour and instead uses alternatives like rice flour, almond flour, or tapioca flour.

These are just a few examples of the many pizza varieties available. Toppings and crust thickness can vary based on personal preferences and regional styles. ''';

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.productName!,
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpaces.spaces_height_10,
                    Text(
                      "\$${double.parse(widget.productPrice!).toStringAsFixed(2)}",
                      style: Get.textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              AppSpaces.spaces_height_10,
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  _productDetails,
                  style: Get.textTheme.bodyMedium,
                ),
              ))),
              AppSpaces.spaces_height_5,
              AppSpaces.spaces_height_5,
              _addToCart(),
              AppSpaces.spaces_height_15,
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
      height: MediaQuery.of(context).size.height * 0.3,
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
            icon: Icon(Icons.arrow_back_ios , color: AppColors.primaryColor,),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: _favourite(),
        ),
        AppCartBardeWidget(iconColor: AppColors.primaryColor),
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
                color: AppColors.primaryColor,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }

  _addToCart() {
    /**/
    bool? _isAlreadyAdded = CartController.to.isAlreadyAddedToCart(ProductNames(
      price: widget.productPrice,
      productName: widget.productName,
      imagePath: widget.productImage,
      product_name_id: int.parse(widget.productId.toString()),
      isActive: 0,
    ));

    if (_isAlreadyAdded != null && _isAlreadyAdded) {
      return Text("Already Added to Cart");
    } else {
      return Container(
        width: Get.width,
        height: 100,
        child: InkWell(
          onTap: () async {
            bool _isAlreadyAdded =
                await CartController.to.isAlreadyAddedToCart(ProductNames(
              price: widget.productPrice,
              productName: widget.productName,
              imagePath: widget.productImage,
              product_name_id: int.parse(widget.productId.toString()),
              isActive: 1,
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

              CartController.to.addToCart(
                  productNames: widget.productNames,
                  count: 1,
                  price: widget.productNames.offer_amount == null
                      ? widget.productNames.price
                      : double.parse(widget.productNames.price.toString()) -
                          (double.parse(widget.productNames.price.toString()) *
                              (double.parse(widget.productNames.offer_amount
                                      .toString()) /
                                  100))
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
          child: AppImageView(image: Assets.imagesAddToCart).getImage(),
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
}
