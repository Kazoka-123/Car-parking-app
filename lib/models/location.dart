class Location{
  final double lat;
  final double lng;
  
  static var parsedJson;

  Location({required this.lat, required this.lng});

  Location.fromJson(Map<dynamic,dynamic> parsedJson)
  :lat = parsedJson['lat'],
  lng = parsedJson['lng'];
}