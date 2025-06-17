import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/login_response.dart';
import '../environment/env.dart';
    
class HttpClient{

  final storage = FlutterSecureStorage();

  postAnalysis(String article) async {
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
      return response.data;
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
          value: jsonData.accessToken,
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

    getHistory() async {
      final token = await storage.read(key: 'jwt');
      if(token == null) return;

      try{
        final dio = Dio();
        final response = await dio.get(
          '${Env.apiBasedUrl}/analyse/history',
          options: Options(
            headers: { 'Authorization': 'Bearer $token' }
          ),
        );
        return response;
      } on DioException catch (error) {
        return error.response;
      } catch (error) {
        return error;
      }
    }

    getAnalysisById(String id) async {
      final token = await storage.read(key: 'jwt');
      try {
        final dio = Dio();
        final response = await dio.get(
          '${Env.apiBasedUrl}/analyse/analysis/$id',
          options: Options(
              headers: { 'Authorization': 'Bearer $token'}
          ),
        );
        return response.data;
      } on DioException catch (error) {
        return error.response;
      } catch (error) {
        return error;
      }
    }

  deleteAnalysisById(String id) async {
    final token = await storage.read(key: 'jwt');
    try {
      final dio = Dio();
      await dio.delete(
        '${Env.apiBasedUrl}/analyse/analysis/$id',
        options: Options(
          headers: { 'Authorization': 'Bearer $token' }
        ),
      );
    } on DioException catch (error) {
      return error.response;
    } catch (error) {
      return error;
    }
  }

}