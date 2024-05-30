import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/Error/failures.dart';
import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_snack_bar/app_snack_bar.dart';
import '../data/domain/model/product_model.dart';
import '../data/repository/StockRepository.dart';
import '../data/repository/vendor_type_repository.dart';


class ProductListController extends GetxController {
  VendorTypeRepository _vendorTypeRepository = new VendorTypeRepository();
  StockRepository _stockRepository = new StockRepository();

  Rx<ProductType> vendorType = new ProductType().obs;

  RxInt selectedIndex = 0.obs;

  RxBool cartLoading = false.obs;

  static ProductListController to = Get.find();

  TextEditingController searchTextEditingController =
      new TextEditingController();

  RxList<ProductNames> searchProductsName = <ProductNames>[].obs;

  RxString searchText = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    cartLoading.value = false;

    selectedIndex.value = 0;
  }

  getVendorType(index) async {
    Either<Failure, ProductType?>? data =
        await _vendorTypeRepository.getProductType(index);




    data.fold((l) {
      AppExceptionHandle.exceptionHandle(l);
    }, (r) {
      /*   r.message.forEach((element) {
        printInfo(
            info:
                "Vendor Type ===========================> ${element.productTypeName}");
      });*/
      vendorType.value = r!;
      update();
    });
  }

  setSelectedIndex(int index) {
    print("Seleted Index ${index}");
    selectedIndex.value = index;
    // update();
  }

  Future<bool> productStock(productId) async {
    setCartLoading(true);
    bool isAvilable = false;

    Either<Failure, Response> response =
        await _stockRepository.productStock(productId);

    setCartLoading(false);

    response.fold((l) {
      isAvilable = false;

      AppExceptionHandle.exceptionHandle(l);
    }, (r) {
      if (r.status.isOk) {
        try {
          var stock = int.parse(r.body["message"][0]["quantity"].toString());

          if (stock > 0) {
            isAvilable = true;
          } else {
            isAvilable = false;
            AppExceptionHandle.errorMessage("Out of stock");
          }
        } catch (err) {
          AppSnackBar.errorSnackbar(msg: "Out of stock.");
        }
      } else {
        isAvilable = false;
        AppExceptionHandle.errorMessage("Something Wrong");
      }
    });

    return isAvilable;
  }

  setCartLoading(bool isLoading) {
    cartLoading.value = isLoading;
  }

  searchProductList(String _searchText) {
    searchText(_searchText);
    searchProductsName.clear();
    searchProductsName.refresh();

    if (_searchText.length > 0) {
      vendorType.value.message?.forEach((element) {
        element.productNames?.forEach((element) {
          if (element.productName!=null && element.productName?.contains(new RegExp(_searchText.toLowerCase(), caseSensitive: false)) == true) {
            searchProductsName.add(element);
            searchProductsName.refresh();
          }
        });
      });
    } else {
      searchProductsName.clear();
      searchProductsName.refresh();
    }
  }

// void addToCart() {
//   print("Befor Add to cart");
//   CartController.to.addToCart();
// }
}
