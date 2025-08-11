import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Core/bindings/controller_binder.dart';
import 'package:network_caller/Core/network/network_checker.dart';
import 'package:network_caller/Features/Authentication/data/data_sources/login_remote_data_sourch.dart';
import 'package:network_caller/Features/Authentication/data/repositories/qibla_repository_impl.dart';
import 'package:network_caller/Features/Authentication/presentation/screens/login_screen.dart';

void main() {
  Get.put(NetworkChecker());
  Get.lazyPut(() => AuthRepository());
  Get.lazyPut(() => LoginRepositoryImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const LoginScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
