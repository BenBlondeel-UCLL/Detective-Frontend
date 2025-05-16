import 'package:dio/dio.dart';


class HttpClient{


  postHttp() async {
    final dio = Dio();
    final response = await dio.post(
      'http://127.0.0.1:8000/analyse', 
      queryParameters: {'text': 'Dit slechte zin.'}
    );
    return response;
  }

  postLogin({required String email, required String password}) async {
    final dio = Dio();
    final response = await dio.post(
      'http://127.0.0.1:8000/api/v1/8000/login',
      data: {email, password},
    );
    return response;
  }

  postSignUp({
    required String username,
    required String email,
    required String password,
    required String passwordRetry,
    }) async {
      if (password == passwordRetry) {
        final dio = Dio();
        final response = await dio.post(
          'http:127.0.0.1:8000/api/v1/8000/signup',
          data: {username, email, password},
        );
        return response;
      } else {
        throw Exception("passwords don't match");
      }
  }
}