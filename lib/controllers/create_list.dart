import 'dart:developer';

import 'package:get/get.dart';

import '../data/services/network_caller.dart';
import '../data/services/urls/urls.dart';

class CreateListController extends GetxController {
  RxBool inProgress = true.obs;

  Future<void> createList(
    String productName,
    String code,
    String img,
    String uPrice,
    String qty,
    String totalPrice,
  ) async {
    inProgress.value = true;
    final result = await NetworkCaller().postMethod(
      Urls.createList,
      body: {
        "ProductName": productName,
        "ProductCode": code,
        "Img": img,
        "UnitPrice": uPrice,
        "Qty": qty,
        "TotalPrice": totalPrice,
      },
    );
    inProgress.value=false;
    if(result!=null&&result['status'] == 'success'){
      log(result.toString());
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
