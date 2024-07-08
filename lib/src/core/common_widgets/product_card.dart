import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/generated/assets.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_image_view_widget.dart';
import 'package:pizza_user_app/src/features/product_details/screen/product_details_screen.dart';
import '../data/local_data/model/favourite_model.dart';
import 'app_image_view_widgets.dart';
import '../utils/colors/app_colors.dart';
import '../utils/spaces/AppSpaces.dart';
import '../../features/cart/controller/CartController.dart';
import '../../features/all_products/controller/ProductListController.dart';

class ProductCard extends StatefulWidget {
  final image;
  final name;
  final price;
  final description;
  final rating;
  final productNames;
  final offer;
  final id;

  final VoidCallback? cartOnTap;

  final Function? onRemove;
  bool? newDesign;

  ProductCard(
      {Key? key,
      this.id,
      this.rating = 0,
      this.name,
      this.image,
      this.description,
      this.price,
      this.cartOnTap,
      this.offer,
      this.productNames,
      this.onRemove})
      : super(key: key);

  ProductCard.newDesign({
    Key? key,
    this.id,
    this.rating = 0,
    this.name,
    this.image,
    this.description,
    this.price,
    this.cartOnTap,
    this.offer,
    this.productNames,
    this.onRemove,
    this.newDesign,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Future<bool> isFav() async => await FavoriteProduct().isFavorite(widget.id);

  @override
  Widget build(BuildContext context) {
    //  print("The key is ${key}");
    print("The key id ${widget.id}");
    print("Offer is ::: ${widget.offer}");

    if (widget.newDesign != null) {
      return _newDesign();
    }
    return TextButton(
      onPressed: () async {
        await Get.to(() => ProductDetailsScreen(
              productNames: widget.productNames,
              productId: widget.id.toString(),
              productName: widget.name.toString(),
              productImage: widget.image.toString(),
              productPrice: widget.price.toString(),
              productDescription: widget.description.toString(),
              productRating: widget.rating.toString(),
            ));

        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                height: 140,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    _image(),
                    AppSpaces.spaces_width_10,
                    _basic_info(),
                  ],
                ),
              ),
              _add_to_cart(),
              _favourite(),
            ],
          ),
        ),
      ),
    );
  }

  _image() {
    print("Current image .... : ${widget.image}");
    return ImageViewWidget(
        imageUrl: widget.image,
        width: 140,
        height: 140,
        borderRadius_top_left: 10,
        borderRadius_bottom_left: 10);
  }

  _basic_info() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpaces.spaces_height_5,
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              widget.name,
              style: Get.textTheme.bodyLarge,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AppSpaces.spaces_height_5,

          Wrap(
            children: [
              Text(
                "Price : ",
                style: Get.textTheme.bodyMedium,
              ),
                   Text(
                "\$${widget.price ?? 100}",
                style: Get.textTheme.bodyMedium?.copyWith(
                    color: widget.offer != 0
                        ? Colors.black54
                        : AppColors.primaryColor,
                  /*  decoration:
                        widget.offer != 0 ? TextDecoration.lineThrough : null*/),
              ),
              AppSpaces.spaces_width_5,
            /*  Visibility(
                visible: widget.offer != 0,
                child: Text(
                  "\$${(double.parse(widget.price.toString()) - (double.parse(widget.price.toString()) * ((widget.offer.toString().endsWith("null") ? 1 : double.parse(widget.offer.toString()) / 100)))).toStringAsFixed(2) ?? 0}",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),*/
            ],
          ),

          //Spacer(),
          Text(
            "Description",
            style: Get.textTheme.bodyMedium?.copyWith(),
          ),

          /*   Flexible(
            child:
          ),*/

          Text(
            widget.description,
            style: Get.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          Spacer(),

          RatingBar.builder(
            initialRating: double.parse(widget.rating.toString()),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 15,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: AppColors.primaryColor,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),

          AppSpaces.spaces_height_5,
        ],
      ),
    );
  }

  _add_to_cart() {
    return Positioned(
      top: 0,
      right: 0,
      child: InkWell(
        //onTap: widget.cartOnTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(0)),
          ),
          height: 40,
          width: 40,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                return ProductListController.to.cartLoading.value == false
                    ? Icon(
                        CartController.to
                                .isAlreadyAddedToCart(widget.productNames)
                            ? Icons.check
                            : Icons.add_shopping_cart,
                        color: AppColors.whiteColor,
                        size: 18,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )),
                      );
              })),
        ),
      ),
    );
  }

  _favourite() {
    return Positioned(
      child: FutureBuilder(
        future: isFav(),
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () async {
              if (snapshot.data == true) {
                FavoriteProduct().deleteFavoriteProduct(widget.id);
                setState(() {});

                widget.onRemove != null ? widget.onRemove!() : Container;
              } else {
                await FavoriteProduct().insertFavoriteProduct(FavoriteProduct(
                  id: widget.id,
                  name: widget.name,
                  image: widget.image,
                  price: widget.price,
                  description: widget.description,
                  discount: widget.offer.toString(),
                  rating: widget.rating.toString(),
                  //   productType: widget.productNames,
                ));

                setState(() {});
              }
            },
            icon: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0)),
              ),
              height: 40,
              width: 40,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  snapshot.data == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.whiteColor,
                  size: 22,
                ),
              ),
            ),
          );
        },
      ),
      right: 0,
      bottom: 0,
    );
  }

  Widget _newDesign() {
    return Container(
      height: 250,
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
      ),
    );
  }
}
