import '../model/all_product_list_model.dart';
import '../service/all_product_list_service.dart';

class AllProductListController {
  Future<AllProductListModel?> getAllProductList() async => await
      AllProductListService().getAllProductList();
}
