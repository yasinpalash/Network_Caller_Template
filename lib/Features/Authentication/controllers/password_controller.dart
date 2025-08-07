import 'package:eventmanagement/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/constants/enum.dart';
import '../../../core/data/models/response_data.dart';
import '../../../core/network/network_checker.dart';
import '../../../core/network/result.dart';
import '../../../core/network/server_exception.dart';
import '../../../core/utils/helpers/snck_bar_helper.dart';
import '../../../core/utils/validators/app_validator.dart';
import '../data/repositories/auth_repository.dart';

class PasswordController extends GetxController {
  final passController = TextEditingController();
  final errorText = ''.obs;
  final email = ''.obs;
  final number = ''.obs;
  final isNew = false.obs;
  final isLoading = false.obs;
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      email.value = args['strEmail'] ?? '';
      number.value = args['strMobileNo'] ?? '';
      isNew.value = args['isNew'] ?? false;
    }
  }

  void password() async {
    bool connected = await NetworkChecker.isConnected();
    if (!connected) {
      errorText.value = 'No internet connection';
      return;
    }
    final input = passController.text.trim();
    final validationResult = AppValidator.validatePassword(input);
    if (validationResult != null) {
      errorText.value = validationResult;
      return;
    }

    isLoading.value = true;
    errorText.value = '';

    try {
      Map<String, dynamic> requestBody;
      if (email.isNotEmpty) {
        requestBody = {
          "strEmail": email.toString(),
          "strPassword": input.toString(),
        };
      } else {
        requestBody = {
          "strMobileNo": number.toString(),
          "strPassword": input.toString(),
        };
      }
      Result<ResponseData> result;

      if (isNew.value) {
        print("New User - Handle accordingly");
        return;
      } else {
        result = await _authRepository.setPassword(requestBody);
      }

      switch (result) {
        case Ok<ResponseData>():
          final response = result.value;
          if (response.isSuccess) {
            Get.offAllNamed(AppRoute.navbar);
          }
          break;

        case Error<ResponseData>():
          final error = result.error;
          if (error is ServerException) {
            errorText.value = error.message;
            if (error.statusCode == 403) {
              AppHelperFunctions.showCustomSnackBar(
                title: 'Wrong password',
                message: 'Please enter a valid password',
                type: SnackBarType.error,
              );
            }
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

  @override
  void onClose() {
    passController.dispose();
    super.onClose();
  }
}
