import 'dart:convert';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_geo_hash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nappiweather/http_config.dart/http_config.dart';
import 'package:nappiweather/models/air_pollution_data.dart';
import 'package:nappiweather/models/air_pollution_response.dart';
import 'package:nappiweather/models/daily_summary.dart';
import 'package:nappiweather/models/fore_cast_response_model.dart';
import 'package:nappiweather/models/geocoding_model.dart';
import 'package:nappiweather/models/weather_model.dart';

import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  var locationList=<Location>[].obs;

var sunriseHour=0.obs;
var sunriseMin=0.obs;
var sunsetHour=0.obs;
var sunsetMin=0.obs;


late VideoPlayerController vcontroller;
  late FlickManager flickManager;

  var weatherAsset=[
    'asset/IMG_1753.mov',

  'asset/weatherimg.jpeg'];
  List weakDays=[
'Sun','Mon','Tue','Wed','Thu','Fri','Sat'

  ];
var currentWeatherData=<Weather>[].obs;
Future<Weather> fetchWeather() async {
//  print('openweather$lat $long');
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${HttpConfig.apiKey}'));
//print('openweather ${response.body}');
  if (response.statusCode == 200) {
    currentWeatherData.add(Weather.fromJson(jsonDecode(response.body)));
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}


  var lat,long;
reverseGeocoding(double lat, double lon,)async{
  int limit=5;
 // var url = Uri.https('example.com', 'whatsit/create');
final String url = '${HttpConfig.reverseGeocoding}lat=$lat&lon=$lon&limit=$limit&appid=${HttpConfig.apiKey}';
try {

      final response = await http.get(Uri.parse(url));
print('response${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          String cityName = data[0]['name'];
          print('City Name: $cityName');
            var jsonList = json.decode(response.body);
  Location locations =Location(name: jsonList[0]['name'], country: jsonList[0]['country']) ;
  locationList.add(locations);
        } else {
          print('No data found for the given coordinates');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error making API call: $error');
    }

}


  getPosition()async{
     var position= await  _determinePosition();
lat=position.latitude;
long=position.longitude;
MyGeoHash myGeoHash = MyGeoHash();
String geoHashValue= myGeoHash.geoHashForLocation(GeoPoint(position.latitude, position.longitude),precision: 5);
reverseGeocoding(position.latitude,position.longitude);
fetchWeather();
fetchWeatherForecast16Days();
fetchAirPollutionData(lat ,long );
fetchAirPollutionDataGroupedByDay(lat,long);
//String hash = geofire.geohashForLocation(GeoPoint(lat, lng));
 //print('position${position}');
 //print('geo hash value $geoHashValue');

  }
  var dayForecasts=<WeatherResponse>[].obs;
//16 day forecast
int noofDays=7;
Future<WeatherResponse> fetchWeatherForecast16Days() async {

  try {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=$noofDays&appid=${HttpConfig.apiKey}'))
  
  .timeout(Duration(seconds: 6), onTimeout: () {
    throw Exception('Request timeout, please check your connection.');
  });
  
  
  if (response.statusCode == 200) {


  //  print('resdatas ${response.body}');


    dayForecasts.add( WeatherResponse.fromJson(jsonDecode(response.body)));
    return WeatherResponse.fromJson(jsonDecode(response.body));
  } else {


    throw Exception('Failed to load weather data');
  }
  } catch (e) {
    throw Exception('Failed to load weather data');
  }
  
}



var airPollutionSummaries = <DailySummary>[].obs;  // Observable list

void fetchAirPollutionDataGroupedByDay(double lati, double longi) async {
  print('fetchairpolltion$lati $longi');
  
  final response = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lati&lon=$longi&appid=${HttpConfig.apiKey}',
    ),
  );

  print('rrrr${jsonDecode(response.body)}');
  if (response.statusCode == 200) {
    print('response is 200');
    final airPollutionData = AirPollutionResponse.fromJson(jsonDecode(response.body));

    // Create a map to group data by day
    Map<DateTime, List<AirPollutionData>> dailyData = {};
    print('hello air${response.body}');
    for (AirPollutionData data in airPollutionData.list!) {
      print('hello air$data');
      DateTime dataDateTime = DateTime.fromMillisecondsSinceEpoch(data.dt! * 1000);
      DateTime dateOnly = DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day);

      if (dailyData.containsKey(dateOnly)) {
        dailyData[dateOnly]!.add(data);
      } else {
        dailyData[dateOnly] = [data];
      }
    }

    // Aggregate and summarize data for each day (for up to 4 days)
    List<DailySummary> summaries = [];

    int count = 0;  // Limit to 4 days
    dailyData.forEach((day, dataList) {
      if (count < 4) {
        // Calculate the highest AQI value for that day
        double maxAqi = dataList
            .map((data) => data.main!.aqi!.toDouble())
            .reduce((a, b) => a > b ? a : b);  // Find the peak AQI

        double maxPm25 = dataList
            .map((data) => data.components!.pm2_5!)
            .reduce((a, b) => a > b ? a : b);  // Find the peak PM2.5 value

        // Add summary for that day with peak AQI
        summaries.add(DailySummary(date: day, averageAqi: maxAqi, maxPm25: maxPm25));
        count++;
      }
    });

    airPollutionSummaries.value = summaries;
  } else {
    print('Failed to load air pollution data');
    throw Exception('Failed to load air pollution data');
  }
}




// //fetch air pollution summary 

// var airPollutionSummaries = <DailySummary>[].obs;  // Observable list

// void fetchAirPollutionDataGroupedByDay(double lati, double longi) async {

//   print('fetchairpolltion$lati $longi');
//   final response = await http.get(
//     Uri.parse(
//       'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lati&lon=$longi&appid=${HttpConfig.apiKey}',
//     ),
//   );

// print('rrrr${jsonDecode(response.body)}');
//   if (response.statusCode == 200) {

//         print('response is 200');
//     final airPollutionData = AirPollutionResponse.fromJson(jsonDecode(response.body));

//     // Create a map to group data by day
//     Map<DateTime, List<AirPollutionData>> dailyData = {};
//    print('hello air${response.body}');
//     for (AirPollutionData data in airPollutionData.list!) {

//       print('hello air$data');
//       DateTime dataDateTime = DateTime.fromMillisecondsSinceEpoch(data.dt! * 1000);
//       DateTime dateOnly = DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day);

//       if (dailyData.containsKey(dateOnly)) {
//         dailyData[dateOnly]!.add(data);
//       } else {
//         dailyData[dateOnly] = [data];
//       }
//     }

    // Aggregate and summarize data for each day (for up to 4 days)
//     List<DailySummary> summaries = [];

//     int count = 0;  // Limit to 4 days
//     dailyData.forEach((day, dataList) {
//       if (count < 4) {
//         double averageAqi = dataList
//             .map((data) => data.main!.aqi!.toDouble())
//             .reduce((a, b) => a + b) /
//             dataList.length;

//         double maxPm25 = dataList
//             .map((data) => data.components!.pm2_5!)
//             .reduce((a, b) => a > b ? a : b);

//         summaries.add(DailySummary(date: day, averageAqi: averageAqi, maxPm25: maxPm25));
//         count++;
//       }
//     });

//     airPollutionSummaries.value = summaries;
//   } else {


//     print('Failed to load air pollution data');
//     throw Exception('Failed to load air pollution data');
//   }
// }



//var airpollution = <AirPollutionData>[].obs;

void fetchAirPollutionData(double lati, double longi) async {


  print('Fetching air pollution data for lat: $lati, lon: $longi');

  final response = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lati&lon=$longi&appid=YOUR_API_KEY',
    ),
  );

  if (response.statusCode == 200) {
    print('Response: ${response.body}');

    // Parse the JSON response
    final airPollutionData = AirPollutionResponse.fromJson(jsonDecode(response.body));

    // Create a map to group data by day
    Map<DateTime, List<AirPollutionData>> dailyData = {};

    // Iterate over each data point
    for (AirPollutionData data in airPollutionData.list!) {
      // Convert dt (Unix timestamp) to DateTime
      DateTime dataDateTime = DateTime.fromMillisecondsSinceEpoch(data.dt! * 1000);

      // Get the date without the time (year, month, day only)
      DateTime dateOnly = DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day);

      // Add the data point to the corresponding day's list
      if (dailyData.containsKey(dateOnly)) {
        dailyData[dateOnly]!.add(data);
      } else {
        dailyData[dateOnly] = [data];
      }
    }

    // Now, we can aggregate and summarize data for each day
    dailyData.forEach((day, dataList) {
      // Example: Calculating the average AQI for the day
      double averageAqi = dataList
          .map((data) => data.main!.aqi!.toDouble())
          .reduce((a, b) => a + b) /
          dataList.length;

      // Example: Finding the max PM2.5 concentration for the day
      double maxPm25 = dataList
          .map((data) => data.components!.pm2_5!)
          .reduce((a, b) => a > b ? a : b);

      // print('Date: $day');
      // print('Average AQI: $averageAqi');
      // print('Max PM2.5: $maxPm25');
      // print('---');
    });

    // You can update your observable or UI with the aggregated data here
    // e.g., airpollutionSummarized.value = dailyDataSummaries;
    
  } else {
    
    //Get.snackbar('Air pollution data', 'Failed to load data');
    throw Exception('Failed to load air pollution data');
  }


  // print('Fetching air pollution data for lat: $lati, lon: $longi');
  
  // final response = await http.get(
  //   Uri.parse(
  //     'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lati&lon=$longi&appid=${HttpConfig.apiKey}',
  //   ),
  // );

  // if (response.statusCode == 200) {
  //   print('Response: ${response.body}');
    
  //   // Parse the JSON response
  //   final airPollutionData = AirPollutionResponse.fromJson(jsonDecode(response.body));
    
  //   // Update the observable list
  //   airpollution.value = airPollutionData.list!;
    
  //   // Example: Accessing AQI from the first element
  //   print('AQI: ${airPollutionData.list?[0].main?.aqi}');
  // } else {
  //   throw Exception('Failed to load air pollution data');
  // }
}

// var airpollution=<AirPollutionData>[].obs;
// void fetchAirPollutionData(double lati ,double longi) async {
//   print('air $lat $long');
//   final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lati&lon=$longi&appid=${HttpConfig.apiKey}'));
//   print('air${response.body}');
//   if (response.statusCode == 200) {
//     // Parse the JSON response
//     final airPollutionData = AirPollutionResponse.fromJson(jsonDecode(response.body));
// airpollution.value=airPollutionData.list!;

//     // You can now access the data, e.g., air quality index
//     print('AQI: ${airPollutionData.list?[0].main?.aqi}');
//   } else {

//     throw Exception('Failed to load air pollution data');
    
//   }
// }




@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
 getPosition();
 //fetchAirPollutionData();
//get users lat and long



//convert to geo hash



//get users city and country


//check if exist in db



//if not exist make api call and stoere in db


 flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController
        .asset('asset/IMG_1753.mov')  
      //    .networkUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
    //)
    );



  }


  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  
  return await Geolocator.getCurrentPosition();
}
}