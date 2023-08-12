// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.onSelectPosition, {super.key});

  final Function onSelectPosition;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewImageUrl;

  Future<void> _showPreview(LatLng location) async {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }

      _showPreview(LatLng(locationData.latitude!, locationData.longitude!));
      widget.onSelectPosition(
        LatLng(locationData.latitude!, locationData.longitude!),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => const MapScreen(),
    ));

    if (selectedPosition == null) return;

    _showPreview(selectedPosition);
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: previewImageUrl == null
              ? const Text('Location not found.')
              : Image.network(
                  previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on the Map'),
            ),
          ],
        ),
      ],
    );
  }
}
