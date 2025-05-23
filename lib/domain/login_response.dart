class LoginResponse {
  final String username;
  final String access_token;
  final String access_type;

  LoginResponse({
    required this.username,
    required this.access_token,
    required this.access_type,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'] ?? '',
      access_token: json['access_token'] ?? '',
      access_type: json['access_type'] ?? '',
    );
  }
}