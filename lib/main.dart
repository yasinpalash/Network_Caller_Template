import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/controller_binder.dart';
import 'package:network_caller/views/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:  SessionsScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

