import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _mapController;
  static const LatLng _initialPosition = LatLng(41.322518, 69.241264);
  bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
    }

    setState(() {
      _hasLocationPermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: _initialPosition,
        zoom: 14.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      markers: {
        const Marker(
          markerId: MarkerId('picked-location'),
          position: _initialPosition,
        ),
      },
      onTap: (LatLng position) {
        setState(() {
          _mapController.animateCamera(
            CameraUpdate.newLatLng(position),
          );
        });
      },
    );
  }
}
