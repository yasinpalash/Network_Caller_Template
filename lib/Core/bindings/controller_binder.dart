import 'package:get/get.dart';
import 'package:network_caller/Features/Authentication/domain/repositories/login_repository.dart';

import '../../Features/Authentication/controllers/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(
        Get.find<LoginRepository>(),
      ),
      fenix: true,
    );
  }
}
