
import 'package:nappiweather/models/cloud_model.dart';
import 'package:nappiweather/models/cord.dart';
import 'package:nappiweather/models/main_model.dart';
import 'package:nappiweather/models/rain_model.dart';
import 'package:nappiweather/models/sys_model.dart';
import 'package:nappiweather/models/weather_condition_model.dart';
import 'package:nappiweather/models/wind_model.dart';

class Weather {
  final Coord coord;
  final List<WeatherCondition> weather;
  final Main main;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final String name;

  Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.wind,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.name,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List).map((i) => WeatherCondition.fromJson(i)).toList(),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt']??0,
      sys: Sys.fromJson(json['sys']),
      name: json['name']??"",
    );
  }
}