import 'package:get/get.dart';

class AppValidator {
  AppValidator._();

  // static String? validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return AppText.emailRequired.tr;
  //   }
  //   final emailRegExp = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!emailRegExp.hasMatch(value)) {
  //     return AppText.emailInvalid.tr;
  //   }
  //   return null;
  // }

  // static String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return AppText.pinRequired.tr;
  //   }
  //   if (value.trim().length != 4) {
  //     return AppText.pinLength.tr;
  //   }
  //   return null;
  // }

  // static String? validateName(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return AppText.nameRequired.tr;
  //   }
  //   if (value.length < 2) {
  //     return AppText.nameTooShort.tr;
  //   }
  //   return null;
  // }

  // static String? validateConfirmPin(String? value, String? originalPassword) {
  //   if (value == null || value.isEmpty) {
  //     return AppText.confirmPinRequired.tr;
  //   }
  //   if (value.length != 4) {
  //     return AppText.pinLength.tr;
  //   }
  //   if (value != originalPassword) {
  //     return AppText.pinsNotMatch.tr;
  //   }
  //   return null;
  // }

  // static String? validateNotEmpty(
  //     String? value, [
  //       String fieldName = '',
  //     ]) {
  //   if (value == null || value.trim().isEmpty) {
  //     return fieldName.isEmpty
  //         ? AppText.fieldRequired.tr
  //         : '$fieldName ${AppText.fieldRequired.tr}';
  //   }
  //   return null;
  // }
}
