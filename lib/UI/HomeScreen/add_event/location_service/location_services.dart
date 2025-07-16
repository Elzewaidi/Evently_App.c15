import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../providers/location_provider.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? selectedLocation;

  _onTap(LatLng Latlng) {
    setState(() {
      selectedLocation = Latlng;
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('pick location'),
        actions: [
          IconButton(
            onPressed: () {
              if (selectedLocation != null) {
                Navigator.maybePop(context, selectedLocation);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please pick a location first')),
                );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              locationProvider.userLocation ?? LatLng(31.0818406, 29.8935053),
          zoom: 17,
        ),
        onTap: _onTap,
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('SELECTED_LOCATION'),
                  position: selectedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
