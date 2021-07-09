import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController instance = Get.find();
  var currentBanner = 0.obs;
}
