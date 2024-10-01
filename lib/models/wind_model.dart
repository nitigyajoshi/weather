class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] .toDouble()??0,
      deg: json['deg']??0,
      gust: json['gust']??0.0,
    );
  }
}