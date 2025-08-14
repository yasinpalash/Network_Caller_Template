import 'package:get/get.dart';
import 'package:network_caller/Features/Authentication/data/repositories/login_repository_impl.dart';
import 'package:network_caller/Features/Authentication/domain/repositories/login_repository.dart';
import '../../Features/Authentication/data/data_sources/login_remote_data_sources.dart';
import '../network/network_checker.dart';

Future<void> initDependencies() async {
  Get.lazyPut<LoginRepository>(
    () => LoginRepositoryImpl(LoginRemoteDataSource()),
    fenix: true,
  );

  await NetworkChecker.init();
}
