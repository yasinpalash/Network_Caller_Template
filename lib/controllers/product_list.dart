import 'package:get/get.dart';
import 'package:network_caller/data/models/product_list.dart';
import 'package:network_caller/data/services/network_caller.dart';

import '../data/services/urls/urls.dart';

class ProductListController extends GetxController {
  final RxBool _inProgress = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<ProductList> _productList = ProductList().obs;

  RxBool get inProgress => _inProgress;
  RxString get errorMessage => _errorMessage;
  Rx<ProductList> get productList => _productList;

  Future<bool> getProductList() async {
    try {
      _inProgress.value = true;
      _errorMessage.value = '';
      final response = await NetworkCaller().getRequest(Urls.readProduct);
      if (response.isSuccess) {
        _productList.value = ProductList.fromJson(response.responseData);
        _inProgress.value = false;
        return true;
      } else {
        _errorMessage.value = response.errorMessage;
        _inProgress.value = false;
        return false;
      }
    } catch (e) {
      print('${e.toString()} in productList ');
      _inProgress.value = false;
      return false;
    }
  }

  @override
  void onInit() {
    getProductList();
    super.onInit();
  }
}
