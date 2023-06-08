import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/screens/search.dart';
import 'package:parkingapp/services/geolocator_service.dart';
import 'package:parkingapp/services/places_service.dart';
import 'package:provider/provider.dart';
import 'models/places.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
          initialData: null,
        ),
        FutureProvider(
          create: (context) {
            ImageConfiguration configuration =
                createLocalImageConfiguration(context);
            return BitmapDescriptor.fromAssetImage(
                configuration, 'assets/images/parking-icon.png');
          },
          initialData: null,
        ),
        ProxyProvider2<Position, BitmapDescriptor, Future<List<Place?>?>?>(
          update: (context, position, icon, places) {
            return placesService.getPlaces(
                position.latitude, position.longitude, icon);
          },
        )
      ],
      child: MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Search(),
      ),
    );
  }
}
