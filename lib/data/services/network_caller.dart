import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../models/response_data.dart';

class NetworkCaller {
  //get methods

  Future<ResponseData> getRequest(String url) async {
    log(url);
    try {
      final Response response = await get(Uri.parse(url),
          headers: {'Content-type': 'application/json'});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse['status'] == 'success') {
          return ResponseData(
              isSuccess: true,
              statusCode: response.statusCode,
              responseData: decodedResponse);
        } else {
          return ResponseData(
              isSuccess: false,
              statusCode: response.statusCode,
              responseData: decodedResponse,
              errorMessage: decodedResponse['data'] ?? 'Something went wrong');
        }
      } else if (response.statusCode == 401) {
        return ResponseData(isSuccess: false, statusCode: response.statusCode, responseData: '');
      }else{
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );

      }
    } catch (e) {
      log(" Error: $e");
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Server error occurred',
      );
    }
  }

  Future<ResponseData> postRequest(String url, {Map<String, String>? body}) async {
    log(url);
    log(body.toString());

    try {
      final Response response = await post(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(body));
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse=jsonDecode(response.body);
        if(decodedResponse['status'] == 'success'){
          return ResponseData(isSuccess: true, statusCode: response.statusCode, responseData: response.body);

        }else{
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
        );
      }else{
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: '',
        );
      }
    } catch (e) {
      log('Error: $e');
      return ResponseData(
        isSuccess: false,
        statusCode: 400,
        responseData: '',
        errorMessage: 'An error occurred: $e',
      );
    }
  }
}
