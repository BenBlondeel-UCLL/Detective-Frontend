import 'package:detective/domain/analysis.dart';
import 'package:detective/enviorement/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:detective/domain/login_response.dart';

class HttpClient{

  final storage = FlutterSecureStorage();

  Future<Analysis> postHttp(String article) async {
    final dio = Dio();
    
    final token = await storage.read(key: 'jwt');

    try {
      final response = await dio.post(
        '${Env.apiBasedUrl}/analyse',
        data: {'text': article},
        options: Options(
          headers: { 'Authorization': 'Bearer $token' }
        ),
      );
      return Analysis.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw Exception('Unable to process the article. The text may be too long or contain unsupported characters.');
      }
      throw Exception('Error sending article: ${e.message}');
    }
  }

  getValidateKey() async {
    final dio = Dio();
    final response = await dio.post(
      '${Env.apiBasedUrl}/auth/me',
    );
    return response;
  }

  postLogin({required String email, required String password}) async {
    final formData = FormData.fromMap({
      'username': email,
      'password': password,
    });
    final dio = Dio();
    try {
      final response = await dio.post(
        '${Env.apiBasedUrl}/auth/login',
        data: formData,
      );
      if (response.statusCode == 200) {
        final jsonData = LoginResponse.fromJson(response.data);
        await storage.write(
          key: 'jwt',
          value: jsonData.access_token,
        );
        await storage.write(
          key: 'username',
          value: jsonData.username,
        );
      }
      return response;
    } on DioException catch (error) {
      return Response(
        requestOptions: error.requestOptions,
        statusCode: error.response?.statusCode ?? 400,
        data: error.response?.data,
      );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: '${Env.apiBasedUrl}/auth/login'),
        statusCode: -1,
        data: null,
      );
    }
  }

  postSignUp({
    required String username,
    required String email,
    required String password,
    }) async {
      try {
        final dio = Dio();
        final response = await dio.post(
          '${Env.apiBasedUrl}/auth/signup',
          data: {
            "username": username,
            "email": email,
            "password": password
          },
        );
        return response;
      } on DioException catch (error) {
        return error.response;
      } catch (error) {
        return error;
      }
    }
}