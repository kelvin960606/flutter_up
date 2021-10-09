import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_up/assets/theme.dart';
import 'package:get/get.dart';

double h(percentage) {
  return Get.mediaQuery.size.height * percentage;
}

double w(percentage) {
  return Get.mediaQuery.size.width * percentage;
}

int random(min, max) {
  var rn = new Random();
  return min + rn.nextInt(max - min);
}

void showSuccess(title, desc) {
  Get.snackbar(
    title,
    desc,
    backgroundColor: appTheme.primaryColor,
    colorText: Colors.white,
  );
}

void showError(title, desc) {
  Get.snackbar(
    title,
    desc,
    backgroundColor: appTheme.errorColor,
    colorText: Colors.white,
  );
}
