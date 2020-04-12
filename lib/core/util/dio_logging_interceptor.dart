import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/flavor_config.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
      print('Headers:');
      options.headers.forEach((k, v) => print('$k: $v'));
      if (options.queryParameters != null) {
        print('queryParameters:');
        options.queryParameters.forEach((k, v) => print('$k: $v'));
      }
      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print("--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    }

    // example for add header authorization
    /*if (options.headers.containsKey(requiredToken)) {
      options.headers.remove(requiredToken);
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }*/
    return options;
  }

  @override
  Future onResponse(Response response) {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
      print('Headers:');
      response.headers?.forEach((k, v) => print('$k: $v'));
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print(
          "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
      print("${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
      print('<-- End error');
    }
    return super.onError(dioError);
  }
}
