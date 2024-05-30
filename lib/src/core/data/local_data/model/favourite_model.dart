import '../db/app_sqlite_database.dart';

class FavoriteProduct {
  var id;
  String? name;
  String? image;
  String? price;
  String? description;
  String? discount;
  String? rating;
  String? productType;
  FavoriteProduct(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.description,
      this.discount,
      this.rating,
      this.productType});

  Future<void> insertFavoriteProduct(FavoriteProduct product) async {
    final db = await DatabaseHelper().database;
    await db.insert('Favorite', product.toMap());
  }

  Future<List<FavoriteProduct>> getFavoriteProducts() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('Favorite');

    return List.generate(maps.length, (index) {
      return FavoriteProduct(
        id: maps[index]['id'],
        name: maps[index]['name'],
        image: maps[index]['image'],
        price: maps[index]['price'],
        description: maps[index]['description'],
        discount: maps[index]['discount'],
        productType: maps[index]['productType'],
        rating: maps[index]['rating'],
      );
    });
  }

  //remove product from favorite
  Future<void> deleteFavoriteProduct(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'Favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //check if product is favorite
  Future<bool> isFavorite(int id) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Favorite',
      where: 'id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'discount': discount,
      'rating': rating,
      'productType': productType,
    };
  }
}
