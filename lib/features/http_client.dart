import 'package:dio/dio.dart';


class HttpClient{


  getHttp() async {
    final dio = Dio();
    final response = await dio.post('http://127.0.0.1:8000/analyse', queryParameters: {'text': 'Dit slechte zin.'});
    return response;
  }
}