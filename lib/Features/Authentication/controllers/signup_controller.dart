import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/models/response_data.dart';
import '../../../core/network/network_checker.dart';
import '../../../core/network/result.dart';
import '../../../core/network/server_exception.dart';
import '../../../core/utils/validators/app_validator.dart';
import '../data/models/sing_up_request.dart';
import '../data/repositories/auth_repository.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final mobileController = TextEditingController();
  final emailOrPhoneController = TextEditingController();
  final errorText = ''.obs;
  final isLoading = false.obs;
  final isTermsAccepted = false.obs;

  final AuthRepository _authRepository = AuthRepository();

  void signUp() async {
    bool connected = await NetworkChecker.isConnected();
    if (!connected) {
      errorText.value = 'No internet connection';
      return;
    }
    final emailInput = emailOrPhoneController.text.trim();
    final validationEmail = AppValidator.validateEmail(emailInput);
    final passwordInput = passController.text.trim();
    final validationPassword = AppValidator.validatePassword(passwordInput);
    final mobileInput = mobileController.text.trim();
    final validationMobile = AppValidator.validatePhoneNumber(mobileInput);
    final nameInput = nameController.text.trim();
    errorText.value = '';

    if (nameInput.isEmpty) {
      errorText.value = '* Name is required *';
      return;
    } else if (validationPassword != null) {
      errorText.value = validationPassword;
      return;
    } else if (validationMobile != null) {
      errorText.value = validationMobile;
      return;
    } else if (validationEmail != null) {
      errorText.value = validationEmail;
      return;
    } else if (!isTermsAccepted.value) {
      errorText.value = '* You must accept Terms & Conditions *';
      return;
    }

    isLoading.value = true;
    errorText.value = '';

    try {
      final signupRequest = SignupRequest(
        strFullName: nameInput,
        strEmail: emailInput,
        strMobileNo: mobileInput,
        strPassword: passwordInput,
      );

      final result = await _authRepository.signup(signupRequest);

      switch (result) {
        case Ok<ResponseData>():
          final response = result.value;
          if (response.isSuccess) {
            Get.snackbar(
              'Success',
              response.message,
              snackPosition: SnackPosition.TOP,
            );
          }
          break;

        case Error<ResponseData>():
          final error = result.error;
          if (error is ServerException) {
            errorText.value = error.message;
            if (error.statusCode == 400) {}
          } else {
            Get.snackbar(
              'Error',
              error.toString(),
              snackPosition: SnackPosition.TOP,
            );
          }
      }
    } catch (e) {
      errorText.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}
