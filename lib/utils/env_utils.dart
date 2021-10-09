import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';

getAPIUrl() {
  return dotenv.env['API_URL'];
}

getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
