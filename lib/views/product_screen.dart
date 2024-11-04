import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_list.dart';

class SessionsScreen extends StatelessWidget {
  final ProductListController _productListController = Get.put(ProductListController());

   SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions UI Screen'),
      ),
      body: Obx(() {
        if (_productListController.inProgress.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_productListController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${_productListController.errorMessage}'));
        } else if (_productListController.productList.value.data == null ||
            _productListController.productList.value.data!.sessions == null ||
            _productListController.productList.value.data!.sessions!.isEmpty) {
          return const Center(child: Text('No sessions available'));
        } else {
          final sessions = _productListController.productList.value.data!.sessions!;
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Level: ${session.level ?? 'N/A'}'),
                      const SizedBox(height: 4.0),
                      Text('Booking Start From: ${session.bookingStartFrom ?? 'N/A'}'),
                      const SizedBox(height: 4.0),
                      Text('Session Topics: ${session.sessionTopics ?? 'N/A'}'),
                      const SizedBox(height: 4.0),
                      Text('Start At: ${session.startAt ?? 'N/A'}'),
                      const SizedBox(height: 8.0),
                      const Divider(),
                      const SizedBox(height: 8.0),
                      if (session.instructor != null) ...[
                        Text(
                          'Instructor: ${session.instructor!.user?.fullName ?? 'No Name'}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Experience: ${session.instructor!.experience ?? 'N/A'}'),
                        Text('Price: \$${session.instructor!.sessionPrice ?? 0}'),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
