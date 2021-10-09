import 'package:flutter_up/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseController extends GetxController {
  ApiService apiService = Get.find();
  SharedPreferences prefs = Get.find();
}
