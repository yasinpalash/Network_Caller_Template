import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Core/bindings/controller_binder.dart';
import 'package:network_caller/Features/Authentication/presentation/screens/login_screen.dart';
import 'Core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
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
