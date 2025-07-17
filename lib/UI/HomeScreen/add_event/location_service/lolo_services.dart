import 'package:eventlyapp/UI/HomeScreen/add_event/location_service/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServices {
  static Future<LatLng?> pickedLocation(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LocationPicker(),
      ),
    );
  }

  static Future<String> getLocationDetails(LatLng position) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return '${placeMark[0].name},${placeMark[0].street},${placeMark[0].subLocality},${placeMark[0].administrativeArea},${placeMark[0].country},';
  }
}
