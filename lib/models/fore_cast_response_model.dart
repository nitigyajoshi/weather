





import 'package:nappiweather/models/city.dart';
import 'package:nappiweather/models/daily_frecast.dart';

class WeatherResponse {
  final City city;
  final String cod;
  final double message;
  final int cnt;
  final List<WeatherList> weatherList;

  WeatherResponse({
    required this.city,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.weatherList,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      city: City.fromJson(json['city']),
      cod: json['cod'] ?? '',
      message: (json['message'] as num?)?.toDouble() ?? 0.0,
      cnt: json['cnt'] ?? 0,
      weatherList: (json['list'] as List).map((item) => WeatherList.fromJson(item)).toList(),
    );
  }
}