import "package:flutter/material.dart";
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:get/get.dart";

import '../../controllers/map/mapcontroller.dart';
import '../../statics/appcolors.dart';

class LocateDropOffOnMap extends StatefulWidget {
  String drop_off;
  LocateDropOffOnMap({Key? key, required this.drop_off}) : super(key: key);

  @override
  State<LocateDropOffOnMap> createState() =>
      _LocateDropOffOnMapState(drop_off: this.drop_off);
}

class _LocateDropOffOnMapState extends State<LocateDropOffOnMap> {
  String drop_off;
  _LocateDropOffOnMapState({required this.drop_off});
  late GoogleMapController mapController;
  late String pickedPickedName = "nothing";
  late double dropOffLat = 0.0;
  late double dropOffLng = 0.0;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final MapController _mapController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("Tap to pick drop off",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: defaultTextColor2)),
          actions: [
            pickedPickedName != "nothing"
                ? TextButton(
                    onPressed: () {
                      _mapController.setDropOffLocation(pickedPickedName);
                      _mapController.setDropOffLat(dropOffLat);
                      _mapController.setDropOffLng(dropOffLng);
                      Get.back();
                    },
                    child: const Text("Okay",
                        style: TextStyle(fontWeight: FontWeight.bold)))
                : Container()
          ]),
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _mapController.userLatitude, _mapController.userLongitude),
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (latLng) async {
                List<Placemark> placemark = await placemarkFromCoordinates(
                    latLng.latitude, latLng.longitude);
                dropOffLat = latLng.latitude;
                dropOffLng = latLng.longitude;

                setState(() {
                  pickedPickedName = placemark[2].street!;
                });
              }),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
                child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryYellow,
                        // borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black26)
                        ]),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text("You have picked $pickedPickedName",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ))),
              ))
        ],
      ),
    ));
  }
}
