import 'package:flutter/material.dart';
import 'package:pizza_user_app/src/core/common_widgets/app_loading.dart';
import 'package:pizza_user_app/src/core/common_widgets/product_card.dart';
import 'package:pizza_user_app/src/core/data/local_data/model/favourite_model.dart';
import 'package:pizza_user_app/src/features/all_products/data/domain/model/product_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<FavoriteProduct>> _favouriteList() async =>
        FavoriteProduct().getFavoriteProducts();
    return Scaffold(
      body: FutureBuilder(
          future: _favouriteList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No Favourite Products"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print("The id is ${snapshot.data![index].id}");
                  print(
                      "The productType is ${snapshot.data![index].productType}");
                  return ProductCard(
                      onRemove: () {
                        setState(() {});
                      },
                      id: snapshot.data![index].id,
                      name: snapshot.data![index].name,
                      image: snapshot.data![index].image,
                      description: snapshot.data![index].description,
                      price: snapshot.data![index].price,
                      rating: snapshot.data![index].rating,
                      offer: snapshot.data![index].discount,
                      productNames: ProductNames(
                        price: snapshot.data![index].price,
                        productName: snapshot.data![index].name,
                        imagePath: snapshot.data![index].image!.replaceAll("https://wingsthingsandpizzas.eventsandimage.com/", ""),
                        product_name_id: snapshot.data![index].id,
                        isActive: 1,
                      ));
                },
              );
            } else {
              return Center(child: AppLoading());
            }
          }),
    );
  }
}
