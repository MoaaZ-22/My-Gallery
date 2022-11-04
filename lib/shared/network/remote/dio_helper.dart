import 'package:dio/dio.dart';

class DioHelper {

  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://technichal.prominaagency.com/api/',
            receiveDataWhenStatusError: true,
            headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken
      })
  async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'

    };
    return await dio.get(url, queryParameters: query,);
  }

  static Future<Response> postData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  static Future<Response> postWithoutData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
       }) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.post(
        url,
        queryParameters: query,
    );
  }

  static Future<Response> putData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }

  static Future<Response> patchData(
      {required String url,
        Map<String, dynamic>? query,String lang = 'en', String? accessToken,
        required Map<String, dynamic> data}) async {

    dio.options.headers =
    {
      'Content-Type':'application/json',
      'Accept' : 'application/json',
      'Accept-Language':lang,
      'Authorization': 'Bearer $accessToken'
    };

    return await dio.patch(
        url,
        queryParameters: query,
        data: data
    );
  }
}
