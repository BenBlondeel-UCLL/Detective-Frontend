import 'package:detective/enviorement/env.dart';
import 'package:dio/dio.dart';

class HttpClient{


  postHttp() async {
    final dio = Dio();
    final response = await dio.post(
      '${Env.apiBasedUrl}/analyse', 
      queryParameters: {'text': 'Dit slechte zin.'}
    );
    return response;
  }

  postLogin({required String email, required String password}) async {
    final dio = Dio();
    final response = await dio.post(
      '${Env.apiBasedUrl}/auth/login',
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
          '${Env.apiBasedUrl}/auth/signup',
          data: {username, email, password},
        );
        return response;
      } else {
        throw Exception("passwords don't match");
      }
  }
}