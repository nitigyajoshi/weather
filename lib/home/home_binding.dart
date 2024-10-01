import 'package:get/get.dart';
import 'package:nappiweather/home/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Eager initialization using Get.put()
    Get.put(HomeController());

    // OR lazy initialization using Get.lazyPut()
    // Get.lazyPut(() => SignupController());
  }
}