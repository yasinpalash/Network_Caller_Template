import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../models/response_data.dart';

class NetworkCaller {
  //get methods
  final int timeoutDuration = 10;

  Future<ResponseData> getRequest(String url) async {
    log('GET Request: $url');
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
      ).timeout(
        Duration(seconds: timeoutDuration),
      );
      return _handleResponse(response);

    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, String>? body}) async {
    log('POST Request: $url');
    log('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await post(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(body)).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);

    } catch (e) {
      return _handleError(e);
    }
  }



  ResponseData _handleResponse(Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (decodedResponse['status'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage: 'Unauthorized - Redirecting to login',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse['data'] ?? 'Something went wrong',
      );
    }
  }
  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }

}
