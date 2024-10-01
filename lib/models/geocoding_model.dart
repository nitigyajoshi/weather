import 'dart:convert';

class Location {
  final String name;

  final String country;

  Location({
    required this.name,
 
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name']??'',
     
      country: json['country']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
   
      'country': country,
    };
  }
}

List<Location> locationsFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationsToJson(List<Location> data) =>
    json.encode(List<Map<String, dynamic>>.from(data.map((x) => x.toJson())));