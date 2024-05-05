import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Applayout {
  static getheightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getwidthSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getscreenheight() {
    return Get.height;
  }

  static getscreenWidth() {
    return Get.width;
  }

  static getheight(double pixels) {
    double x = getscreenheight() / pixels;

    return getscreenheight() / x;
  }

  static getWidth(double pixels) {
    double x = getscreenWidth() / pixels;

    return getscreenWidth() / x;
  }
}
