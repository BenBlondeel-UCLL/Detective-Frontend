import 'package:detective/domain/analysis.dart';
import 'package:detective/enviorement/env.dart';
import 'package:dio/dio.dart';

class HttpClient{


  Future<Analysis> postHttp(String article) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        '${Env.apiBasedUrl}/analyse',
        data: {'text': article},
      );
      return Analysis.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw Exception('Unable to process the article. The text may be too long or contain unsupported characters.');
      }
      throw Exception('Error sending article: ${e.message}');
    }
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