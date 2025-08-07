class SignupRequest {
  final String strFullName;
  final String strEmail;
  final String strMobileNo;
  final String strPassword;


  SignupRequest({
    required this.strFullName,
    required this.strEmail,
    required this.strMobileNo,
    required this.strPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'strFullName': strFullName,
      'strEmail': strEmail,
      'strMobileNo': strMobileNo,
      'strPassword': strPassword
    };
  }
}