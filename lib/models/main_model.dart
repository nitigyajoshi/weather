class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp']??0.0,
      feelsLike: json['feels_like']??0.0,
      tempMin: json['temp_min']??0.0,
      tempMax: json['temp_max']??0.0,
      pressure: json['pressure']??0,
      humidity: json['humidity']??0,
    );
  }
}
