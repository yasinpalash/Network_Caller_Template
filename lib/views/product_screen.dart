import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/controllers/product_list.dart';

import 'create_product_screen.dart';


class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductListController productListController = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Screen")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to( ProductForm());
        },
      ),
      body: Obx(() {
        if (productListController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            itemCount: productListController.productList.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final product = productListController.productList.data?[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product?.img ?? ''),
                ),
                title: Text(product?.productName ?? ''),
                subtitle: Text(product?.productCode ?? ''),
                trailing: Text('\$${product?.unitPrice.toString() ?? ''}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        }
      }),
    );
  }
}