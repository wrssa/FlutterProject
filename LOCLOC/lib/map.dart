import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final int groupId;

  const MapScreen({super.key, required this.groupId});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late Position _currentPosition;
  bool _locationLoaded = false;
  late CameraPosition _kGoogle;

  // on below line we have created the list of markers
  List<Marker> _markers = [];
  List<Map<String, dynamic>> _members = [];

  // created method for getting user current location
  Future<void> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) async {
        await Geolocator.requestPermission();
        print("ERROR" + error.toString());
      },
    );
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _locationLoaded = true;

      // add marker for current user location
      _markers.add(
        Marker(
          markerId: const MarkerId("my_location"),
          position: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          infoWindow: const InfoWindow(
            title: 'My Location',
          ),
        ),
      );
    });
  }

  // create method to get member locations from Firestore
  Future<void> _getMemberLocations() async {
    await FirebaseFirestore.instance
        .collection('group')
        .doc(widget.groupId.toString())
        .collection('members')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic>? data = doc.data();
        final String name = data!['name'];
        final double latitude = data['latitude'].toDouble();
        final double longitude = data['longitude'].toDouble();
        final String pic = data['pic'];
        if (kDebugMode) {
          print('$name $latitude $longitude');
        }

        // add member data to list
        _members.add({
          'name': name,
          'latitude': latitude,
          'longitude': longitude,
          'pic': pic,
        });
      });

      // add markers for member locations
      _members.forEach((Map<String, dynamic> member) {
        _markers.add(
          Marker(
            markerId: MarkerId(member['name']),
            position: LatLng(member['latitude'], member['longitude']),
            infoWindow: InfoWindow(
              title: member['name'],
            ),
          ),
        );
      });

      setState(() {});
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getMemberLocations().then((_) {
      if (_members.isNotEmpty) {
        Map<String, dynamic> firstMember = _members.first;
        setState(() {
          _kGoogle = CameraPosition(
            target: LatLng(
              firstMember['latitude'],
              firstMember['longitude'],
            ),
            zoom: 15,
          );
        });
      }
      _getUserCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _locationLoaded
                ? GoogleMap(
                    initialCameraPosition: _kGoogle,
                    markers: Set<Marker>.of(_markers),
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = _members[index];
                return SizedBox(
                  width: 120,
                  child: Column(
                    children: [
                      if (member['pic'] != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(member['pic']),
                          radius: 30,
                        ),
                      Text(member['name']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
