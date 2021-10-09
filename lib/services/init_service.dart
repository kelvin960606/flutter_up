import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_up/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

Future initServices() async {
  await dotenv.load(fileName: ".env");
  await Get.putAsync(() => SharedPreferences.getInstance());
  var apiService = Get.put(ApiService());
  var authController = Get.put(AuthController());
  apiService.init();
  await authController.init();
}
