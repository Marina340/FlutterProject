import 'dart:async';
import 'package:ass1/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => MapScreen();
}
double long=27;
double lat=25;
class MapScreen extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  Set<Polyline> _polylines = Set<Polyline>();
  int id = 1;
  void _saveMarkers() {
    // Implement your logic to save the markers here
    print('Markers saved: $markers $long $lat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: (LatLng latLng) {
              Marker marker = Marker(
                markerId: MarkerId('$id'),
                position: LatLng(latLng.latitude, latLng.longitude),
                infoWindow: InfoWindow(title: 'company location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              );
              long=latLng.longitude;
              lat=latLng.latitude;
              markers.add(marker);
              setState(() {});
              print('$latLng');
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.43296265331129, -122.08832357078792),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers.toSet(),
            polylines: _polylines,
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed:()async{
                _saveMarkers();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(long,lat)));
              },
              child: Text('Save Markers'),
            ),
          ),
        ],
      ),
    );
  }
}
