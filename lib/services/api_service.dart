import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_up/utils/env_utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiService extends GetxService {
  static String apiEndpoint = getAPIUrl();
  static const bool debug = kDebugMode;

  Dio dio = new Dio(new BaseOptions(
    baseUrl: apiEndpoint,
    contentType: 'application/json',
    connectTimeout: 60000,
  ));

  void init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (debug) {
          print("\n================== 请求数据 ==========================");
          print("url = ${options.uri.toString()}");
          print("headers = ${options.headers}");
          print("params = ${options.data}");
          if ((options.data.toString().contains('FormData'))) {
            options.data.fields.forEach((element) {
              print('${element.key} : ${element.value}');
            });
          }
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (debug) {
          print("\n================== 响应数据 ==========================");
          print("url = ${response.realUri.toString()}");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print("\n");
        }
        if (response.statusCode! == 401) {
          if (response.data['message'] != null) {
            // showError('Error', response.data['message']);
            // AuthController authController = Get.find();
            // authController.forceLogout();
          }
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (debug) {
          print("\n================== 错误响应数据 ======================");
          print("type = ${error.type}");
          print("message = ${error.message}");
          print("stackTrace = ${error.error}");
          print("response = ${error.response}");
          print("\n");
        }
        handler.next(error);
      },
    ));
  }

  Future apiRequest(
    String path,
    String type,
    dynamic data,
    String? baseUrl,
  ) async {
    dio.options.baseUrl = baseUrl ?? apiEndpoint;
    var response;

    if (type == 'get') {
      response = await dio.get(path, queryParameters: data);
    } else if (type == 'post') {
      response = await dio.post(path, data: data);
    } else if (type == 'put') {
      response = await dio.put(path, data: data);
    } else if (type == 'delete') {
      response = await dio.delete(path, data: data);
    } else if (type == 'patch') {
      response = await dio.patch(path, queryParameters: data);
    } else {
      response = await dio.get(path);
    }
    var json = jsonDecode(response.toString());
    return json;
  }

  Future getBaseToken() async {
    return await apiRequest('/api/App/token?client=pc', 'post', null, null);
  }

  Future login(data) async {
    return await apiRequest('/api/System/login', 'post', data, null);
  }

  Future logout() async {
    return await apiRequest('/api/User/logout', 'post', null, null);
  }
}
