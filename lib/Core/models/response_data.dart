class ResponseData<T> {
  final bool isSuccess;
  final String message;
  final T? data;

  /// 🔹 Keep a copy of the entire raw JSON
  final Map<String, dynamic> rawBody;

  ResponseData({
    required this.isSuccess,
    required this.message,
    this.data,
    required this.rawBody,
  });

  factory ResponseData.fromJson(
      Map<String, dynamic> json, {
        T Function(dynamic)? fromJsonT,
      }) {
    return ResponseData<T>(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : json['data'],
      rawBody: json,
    );
  }

  @override
  String toString() {
    return "ResponseData(isSuccess: $isSuccess, message: $message, data: $data, rawBody: $rawBody)";
  }
}
