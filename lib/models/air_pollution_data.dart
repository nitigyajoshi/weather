


import 'package:nappiweather/models/component.dart';
import 'package:nappiweather/models/main_data.dart';

class AirPollutionData {
  int? dt;
  MainData? main;
  Components? components;

  AirPollutionData({this.dt, this.main, this.components});

  factory AirPollutionData.fromJson(Map<String, dynamic> json) {
    return AirPollutionData(
      dt: json['dt'],
      main: json['main'] != null ? MainData.fromJson(json['main']) : null,
      components:
          json['components'] != null ? Components.fromJson(json['components']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main?.toJson(),
      'components': components?.toJson(),
    };
  }
}