import 'dart:io';

final class Env {
  static String get apiUrl{
    try{
      if (Platform.isAndroid) {
        return "http://10.0.2.2:8000";
      }
      return "http://127.0.0.1:8000";
    } catch (e){
      return "http://127.0.0.1:8000";
    }
  }

  static String apiBasedUrl = apiUrl;
}
