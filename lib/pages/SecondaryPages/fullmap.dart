import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FULLMAP extends StatefulWidget {
  const FULLMAP({super.key});

  @override
  _FULLMAPState createState() => _FULLMAPState();
}

class _FULLMAPState extends State<FULLMAP> {
  late GoogleMapController mapController;

  // NSBM Green University coordinates
  // Location: Mahenwaththa, Pitipana, Homagama, Sri Lanka
  // Latitude: 6.82° North, Longitude: 80.04° East
  final LatLng _nsbmLocation = const LatLng(6.82, 80.04);

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('nsbm_campus'),
          position: _nsbmLocation,
          infoWindow: const InfoWindow(
            title: 'NSBM Green University',
            snippet: 'Mahenwaththa, Pitipana, Homagama, Sri Lanka\nLat: 6.82°N, Long: 80.04°E',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Campus Map'),
        backgroundColor: const Color.fromARGB(255, 132, 192, 2),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _nsbmLocation,
          zoom: 16.0,
        ),
        markers: _markers,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
