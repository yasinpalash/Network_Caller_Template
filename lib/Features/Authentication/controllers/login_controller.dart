import 'package:eventmanagement/core/utils/helpers/snck_bar_helper.dart';
import 'package:eventmanagement/core/utils/logger.dart';
import 'package:eventmanagement/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enum.dart';
import '../../../core/data/models/response_data.dart';
import '../../../core/network/network_checker.dart';
import '../../../core/network/result.dart';
import '../../../core/network/server_exception.dart';
import '../../../core/utils/validators/app_validator.dart';
import '../data/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final errorText = ''.obs;
  final AuthRepository _authRepository = AuthRepository();
  final isLoading = false.obs;

  void login() async {
    errorText.value = '';

    try {
      bool connected = await NetworkChecker.isConnected();
      if (!connected) {
        errorText.value = 'No internet connection';
        return;
      }

      final emailInput = emailOrPhoneController.text.trim();

      if (emailInput.isEmpty) {
        errorText.value = 'Email or phone is required';
        return;
      }

      final isEmail = AppValidator.validateEmail(emailInput) == null;
      final isPhone = AppValidator.validatePhoneNumber(emailInput) == null;
      if (!isEmail && !isPhone) {
        errorText.value = 'Invalid email or phone number';
        return;
      }
      isLoading.value = true;
      Map<String, dynamic> requestBody;
      if (isEmail) {
        requestBody = {"strEmail": emailInput};
      } else {
        requestBody = {"strMobileNo": emailInput};
      }

      final result = await _authRepository.login(requestBody);

      switch (result) {
        case Ok<ResponseData>():
          final response = result.value;
          if (response.isSuccess) {

          }
          break;

        case Error<ResponseData>():
          final error = result.error;
          if (error is ServerException) {
            errorText.value = error.message;

            if (error.statusCode == 404) {
              AppHelperFunctions.showCustomSnackBar(
                title: 'Account Not Found',
                message: 'Please create an account first',
                type: SnackBarType.error,
              );
            } else if (error.statusCode == 400) {
              errorText.value='';
              Get.toNamed(
                AppRoute.passwordScreen,
                arguments: {
                  'strEmail': isEmail ? emailInput : null,
                  'strMobileNo': isPhone ? emailInput : null,
                  'isNew': false,
                },
              );
            } else if (error.statusCode == 412) {
              errorText.value='';
              Get.toNamed(
                AppRoute.passwordScreen,
                arguments: {
                  'strEmail': isEmail ? emailInput : null,
                  'strMobileNo': isPhone ? emailInput : null,
                  'isNew': true,
                },
              );
            }
          } else {
            AppHelperFunctions.showCustomSnackBar(
              title: 'Server Error',
              message: 'Please try again later',
              type: SnackBarType.error,
            );
          }
          break;
      }
    } catch (e) {
      AppLoggerHelper.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
