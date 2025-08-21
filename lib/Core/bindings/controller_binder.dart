import 'package:get/get.dart';
import 'package:network_caller/Features/Authentication/domain/repositories/login_repository.dart';
import 'package:network_caller/Features/Courses/controllers/course_list_controller.dart';
import 'package:network_caller/Features/Courses/domain/repositories/course_repository.dart';
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

    Get.lazyPut<CourseListController>(
          () => CourseListController(
        Get.find<CourseRepository>(),
      ),
      fenix: true,
    );
  }
}
