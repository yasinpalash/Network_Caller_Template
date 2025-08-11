import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:network_caller/Features/Authentication/data/repositories/qibla_repository_impl.dart';
import 'package:network_caller/Features/Authentication/domain/repositories/login_repository.dart';

import '../../Features/Authentication/data/data_sources/login_remote_data_sourch.dart';
import '../network/network_checker.dart';

Future<void> initDependencies() async {
  Get.lazyPut<LoginRepository>(
    () => LoginRepositoryImpl(AuthRepository()),
    fenix: true,
  );

  Get.put(NetworkChecker());
  Get.lazyPut(() => AuthRepository());
}
