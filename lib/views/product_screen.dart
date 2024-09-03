import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/controllers/product_list.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productListController = Get.find<ProductListController>();
    // Check if the product list is already loaded, if not, fetch it
    if (productListController.productList.value.data == null ||
        productListController.productList.value.data!.isEmpty) {
      productListController.getProductList();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Product Screen")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Get.to( ProductForm());
        },
      ),
      body: Obx((){
        if(productListController.inProgress.value){
          return const Center(child: CircularProgressIndicator());
        }
        if (productListController.errorMessage.isNotEmpty) {
          return Center(child: Text(productListController.errorMessage.value));
        }
        if (productListController.productList.value.data == null ||
            productListController.productList.value.data!.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return ListView.separated(
          itemCount: productListController.productList.value.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final product = productListController.productList.value.data?[index];
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
            return const Divider();
          },
        );
      }),
    );
  }
}