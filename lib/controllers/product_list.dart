import 'dart:developer';

import 'package:get/get.dart';

import '../data/models/product_list.dart';
import '../data/services/network_caller.dart';
import '../data/services/urls/urls.dart';

class ProductListController extends GetxController {
  RxBool isLoading = true.obs;
  ProductList _productList = ProductList();
  ProductList get productList => _productList;

  Future<void> getProduct() async {
    isLoading.value = true;
    final response = await NetworkCaller().getMethod(Urls.readProduct);
    log('API Response: ${response.toString()}');
    isLoading.value = false;
    if (response['status'] == 'success') {
      _productList = ProductList.fromJson(response);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProduct();
  }
}