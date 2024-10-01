
// AirPollutionResponse model class





import 'package:nappiweather/models/air_pollution_data.dart';
import 'package:nappiweather/models/cord.dart';

class AirPollutionResponse {
  Coord? coord;
  List<AirPollutionData>? list;

  AirPollutionResponse({this.coord, this.list});

  factory AirPollutionResponse.fromJson(Map<String, dynamic> json) {
    return AirPollutionResponse(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      list: json['list'] != null
          ? List<AirPollutionData>.from(
              json['list'].map((item) => AirPollutionData.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord?.toJson(),
      'list': list?.map((item) => item.toJson()).toList(),
    };
  }
}