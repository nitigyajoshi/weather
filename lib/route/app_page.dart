import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nappiweather/home/home.dart';
import 'package:nappiweather/home/home_binding.dart';
import 'package:nappiweather/route/app_routes.dart';
import 'package:nappiweather/weather_detail/weather_deatil_binding.dart';
import 'package:nappiweather/weather_detail/weather_detail_view.dart';




class AppPages {
  AppPages._();
  static const INITIAL =
   Routes.HOME;

  static final routes = [
  GetPage(
      name: _Paths.HOME,
      page: () => HomeView (),
      binding: 
      HomeBinding(),
    ),
GetPage(
      name: _Paths.weatherDetail,
      page: () =>  WeatherDetail(),
      binding: 
      WeatherDetailBinding(),
    ),

//     GetPage(
//       name: _Paths.CARTUSER,
//       page: () =>  UserCartView(),
//       binding: 
//       UserCartBinding(),
//     ),

//     GetPage(
//       name: _Paths.DELIVERYDETAIL,
//       page: () =>  DeliverySummaryViewUser(),
//       binding: 
//       DeliverySummaryBinding(),
//     ),
  ];
  


  }
  abstract class _Paths {
  
  
  _Paths._();
    static const HOME = '/home';

    static const weatherDetail = '/weatherDetail';
    static const CARTUSER = '/cartUser';
 static const DELIVERYDETAIL = '/deliveryDetail';
  }