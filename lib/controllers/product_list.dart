import 'dart:developer';
import 'package:get/get.dart';
import 'package:network_caller/data/models/product_list.dart';
import 'package:network_caller/data/services/network_caller.dart';




class ProductListController extends GetxController {
  final RxBool _inProgress = true.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<HomeModels> _productList = HomeModels().obs;

  RxBool get inProgress => _inProgress;
  RxString get errorMessage => _errorMessage;
  Rx<HomeModels> get productList => _productList;

  void fetchProductList() async {
    try {
      _inProgress(true);
      _errorMessage.value = '';

      final response = await NetworkCaller(baseUrl: 'https://employee-beryl.vercel.app/api/v1').getRequest('/students/courses-session');
      if (response.isSuccess) {
        _productList.value = HomeModels.fromJson(response.responseData);
      } else {
        _errorMessage.value = response.errorMessage;
      }
    } catch (e) {
    log("Error: $e");
    }finally{
      _inProgress(false);
    }
  }

  @override
  void onInit() {
    fetchProductList();
    super.onInit();
  }
}
