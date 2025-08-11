import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Core/models/response_data.dart';
import 'package:network_caller/Core/network/server_exception.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';
import 'package:network_caller/Features/Authentication/data/repositories/qibla_repository_impl.dart';
import 'package:network_caller/core/network/result.dart';

class LoginController extends GetxController {
  final LoginRepositoryImpl _loginRepository = LoginRepositoryImpl();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both username and password");
      return;
    }

    isLoading.value = true;

    final result = await _loginRepository.login(
      SignInRequest(username: username, password: password),
    );

    isLoading.value = false;

    switch (result) {
      case Ok<ResponseData>(value: final response):
        if (response.isSuccess) {
          Get.snackbar("Success", "Login successful!");
          // Navigate or store tokens here
        } else {
          Get.snackbar("Login Failed", response.message ?? "Unknown error");
        }
        break;

      case Error<ResponseData>(error: final error):
        if (error is ServerException) {
          Get.snackbar("Server Error", error.message);
        } else {
          Get.snackbar("Error", error.toString());
        }
        break;
    }
  }
}
