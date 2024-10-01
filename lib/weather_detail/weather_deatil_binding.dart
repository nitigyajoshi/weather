
import 'package:get/get.dart';
import 'package:nappiweather/weather_detail/weather_detail_controller.dart';

class WeatherDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Eager initialization using Get.put()
    Get.put(WeatherDetailController());

    // OR lazy initialization using Get.lazyPut()
    // Get.lazyPut(() => SignupController());
  }
}