import 'package:flutter_up/utils/common_utils.dart';
import 'package:get/get.dart';

import 'BaseController.dart';

class AuthController extends BaseController {
  RxString baseToken = ''.obs;
  RxString token = ''.obs;

  Future init() async {
    var data = prefs.getString('token');
    if (data != null) {
      await updateAuthToken(data);
    } else {
      await getBaseToken();
    }
  }

  Future getBaseToken() async {
    var json = await apiService.getBaseToken();
    if (json['status']) {
      if (json['data']['token'] != null) {
        updateBaseToken(json['data']['token']);
      }
    }
  }

  void updateBaseToken(t) {
    baseToken.value = t;
    updateToken(t);
  }

  Future updateAuthToken(t) async {
    token.value = t;
    await prefs.setString('token', t);
    updateToken(t);
  }

  Future updateToken(data) async {
    apiService.dio.options.headers.remove('Authorization');
    apiService.dio.options.headers.addIf(
        !apiService.dio.options.headers.containsKey('Authorization'),
        'Authorization',
        'Bearer $data');
  }

  String getToken() {
    return prefs.getString('token')!;
  }

  void deleteToken() async {
    token.value = '';
    apiService.dio.options.headers.remove('Authorization');
    await prefs.remove('token');
  }

  void logout() async {
    var json = await apiService.logout();
    if (json['success']) {
      logoutSuccess();
    } else {
      showError('Logout Failed', 'Please try again');
    }
  }

  void forceLogout() {
    deleteToken();
    Get.until((route) => Get.currentRoute == '/auth');
    Get.toNamed('/auth');
  }

  void logoutSuccess() {
    deleteToken();
    showSuccess('Log Out', 'Log Out Success');
    Get.until((route) => Get.currentRoute == '/auth');
    Get.toNamed('/auth');
  }

  bool isLogin() {
    return token.value.isNotEmpty ? true : false;
  }
}
