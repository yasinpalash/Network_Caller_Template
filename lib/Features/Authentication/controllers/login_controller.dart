import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';
import '../../../Core/models/response_data.dart';
import '../../../Core/network/result.dart';
import '../../../Core/network/server_exception.dart';
import '../domain/repositories/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository;
  LoginController(this._loginRepository);

  var usernameController = TextEditingController( text: "emilys");
  var passwordController = TextEditingController(text: "emilyspass");
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
      case Ok<ResponseData>():
        final response = result.value;
        print("Login response: ${response.data}");
        if (response.isSuccess) {
          final data = response.data;
          print("Login successful: ");
        }
        break;

      case Error<ResponseData>():
        final error = result.error;
        if (error is ServerException) {}
    }
  }
}
