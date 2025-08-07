class ResponseData {
  final int statusCode;
  final String message;
  final dynamic data;

  ResponseData({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }

  bool get isSuccess => statusCode == 200 || statusCode == 201;
  bool get isError => !isSuccess;
}
