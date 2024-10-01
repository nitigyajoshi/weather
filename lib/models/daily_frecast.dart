
import 'package:nappiweather/models/feels_like_model.dart';
import 'package:nappiweather/models/temp.dart';
import 'package:nappiweather/models/weather_condition_model%20(1).dart';

class WeatherList {
  final int dt;
  final int sunrise;
  final int sunset;
  final Temp temp;
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final List<WeatherCondition> weather;
  final double speed;
  final int deg;
  final double? gust;
  final int clouds;
  final double pop;
  final double? rain;

  WeatherList({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.weather,
    required this.speed,
    required this.deg,
    this.gust,
    required this.clouds,
    required this.pop,
    this.rain,
  });

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      dt: json['dt'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
      temp: Temp.fromJson(json['temp']),
      feelsLike: FeelsLike.fromJson(json['feels_like']),
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      weather: (json['weather'] as List).map((i) => WeatherCondition.fromJson(i)).toList(),
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      deg: json['deg'] ?? 0,
      gust: (json['gust'] as num?)?.toDouble(),
      clouds: json['clouds'] ?? 0,
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      rain: (json['rain'] as num?)?.toDouble(),
    );
  }
}