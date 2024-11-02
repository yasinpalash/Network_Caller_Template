import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../models/response_data.dart';

class NetworkCaller {
  final int timeoutDuration = 10;
  final http.Client _client;
  final String baseUrl;

  NetworkCaller({http.Client? client, required this.baseUrl}) : _client = client ?? http.Client();

  // Common headers (e.g., for authentication)
  Map<String, String> _getHeaders() => {
    'Content-type': 'application/json',
    // Add 'Authorization': 'Bearer <token>' if necessary
  };

  Future<ResponseData> getRequest(String endpoint) async {
    final String url = '$baseUrl$endpoint';
    log('GET Request: $url');
    try {
      final response = await _client
          .get(
        Uri.parse(url),
        headers: _getHeaders(),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequest(String endpoint, {Map<String, dynamic>? body}) async {
    final String url = '$baseUrl$endpoint';
    log('POST Request: $url');
    log('Request Body: ${jsonEncode(body)}');

    try {
      final response = await _client
          .post(
        Uri.parse(url),
        headers: _getHeaders(),
        body: jsonEncode(body),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  ResponseData _handleResponse(http.Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    final decodedResponse = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      case 204:
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: null,
        );
      case 401:
      // Handle token refresh logic if required
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized - Redirecting to login', responseData: null,
        );
      case 404:
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Resource not found', responseData: null,
        );
      case 500:
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Internal server error', responseData: null,
        );
      default:
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['error'] ?? 'Something went wrong', responseData: null,
        );
    }
  }

  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        errorMessage: 'Request timeout. Please try again later.', responseData: null,
      );
    } else if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Network error occurred. Please check your connection.', responseData: null,
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Unexpected error occurred.', responseData: null,
      );
    }
  }

  void dispose() {
    _client.close();
  }
}



// Usage Example:
// final networkCaller = NetworkCaller(baseUrl: 'https://api.example.com/');
// final response = await networkCaller.getRequest('/endpoint');
