import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place_location.model.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen({
    this.isSelecting = true,
    this.location =
        const PlaceLocation(latitude: 55.76, longitude: 37.62, address: ''),
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: widget.location.address == '' ? 10 : 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting) ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ?? LatLng(
                    widget.location.latitude,
                    widget.location.longitude,
                  ),
          ),
        },
      ),
    );
  }
}
