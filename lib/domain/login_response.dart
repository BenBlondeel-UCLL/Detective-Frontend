class LoginResponse {
  final String username;
  final String accessToken;
  final String accessType;

  LoginResponse({
    required this.username,
    required this.accessToken,
    required this.accessType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'] ?? '',
      accessToken: json['access_token'] ?? '',
      accessType: json['access_type'] ?? '',
    );
  }
}