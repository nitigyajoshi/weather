class MainData {
  int? aqi;

  MainData({this.aqi});

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(
      aqi: json['aqi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aqi': aqi,
    };
  }
}