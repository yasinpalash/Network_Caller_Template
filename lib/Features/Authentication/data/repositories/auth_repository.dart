import 'package:dio/dio.dart';

import '../models/sing_up_request.dart';

class AuthRepository {
  final Dio _dio = ApiClient.createDio();

  Future<Result<ResponseData>> login(Map<String, dynamic> data) async {
    return await _dio.postRequest<ResponseData>(
      AppUrls.login,
      fromJson: (json) => ResponseData.fromJson(json),
      data: data,
    );
  }
}
