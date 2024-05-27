import 'dart:convert';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:taxinet/screens/drive_and_pay/requestdriveandpay.dart';

import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import '../payanddrive/requestpayanddrive.dart';

class CarDetails extends StatefulWidget {
  final id;
  const CarDetails({super.key, required this.id});

  @override
  State<CarDetails> createState() => _CarDetailsState(id: this.id);
}

class _CarDetailsState extends State<CarDetails> {
  final id;
  _CarDetailsState({required this.id});
  bool isLoading = true;
  final storage = GetStorage();
  late String uToken = "";
  late List allCarIDetail = [];
  late List allCarIDetailImages = [];
  late String detailId = "";
  late String name = "";
  late String price = "";
  late String location = "";
  late String milage = "";
  late String engine_type = "";
  late String interior_color = "";
  late String exterior_color = "";
  late String vin = "";
  late String car_id = "";
  late String transmission = "";
  late String fog_light = "";
  late String pust_start = "";
  late String reverse_camera = "";
  late String drive_type = "";
  late String rent_type = "";
  var items;

  Future<void> getCarDetails() async {
    final profileLink = "https://taxinetghana.xyz/car_sales/get_vehicle/$id/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      detailId = jsonData['id'].toString();
      name = jsonData['name'];
      price = jsonData['price'];
      rent_type = jsonData['rent_type'];
      location = jsonData['location'];
      milage = jsonData['millage'].toString();
      engine_type = jsonData['engine_type'];
      interior_color = jsonData['interior_color'];
      exterior_color = jsonData['exterior_color'];
      vin = jsonData['vin'];
      car_id = jsonData['car_id'];
      drive_type = jsonData['drive_type'];
      transmission = jsonData['transmission'];
      fog_light = jsonData['fog_light'].toString();
      pust_start = jsonData['push_start'].toString();
      reverse_camera = jsonData['reverse_camera'].toString();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getCarImages() async {
    final profileLink =
        "https://taxinetghana.xyz/car_sales/get_all_vehicles_images/$id/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allCarIDetail = jsonData;
      for (var i in allCarIDetail) {
        if (!allCarIDetailImages.contains(i['get_car_pic'])) {
          allCarIDetailImages.add(i['get_car_pic']);
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  @override
  void initState() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    getCarDetails();
    getCarImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Details"),
        leading: const LeadingButton(),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     if (rent_type == "Pay And Drive") {
          //       Get.to(() => RequestPayAndDrive(
          //           id: detailId,
          //           drive_type: drive_type,
          //           rent_type: rent_type));
          //     } else {
          //       Get.to(() => RequestDriveAndPay(
          //           id: detailId,
          //           drive_type: drive_type,
          //           rent_type: rent_type));
          //     }
          //   },
          //   child: const Text("Request Call",
          //       style: TextStyle(fontWeight: FontWeight.bold)),
          // )
        ],
      ),
      body: isLoading
          ? const LoadingUi()
          : SlideInUp(
              animate: true,
              child: ListView(
                children: [
                  // car detail images
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allCarIDetailImages != null
                            ? allCarIDetailImages.length
                            : 0,
                        itemBuilder: (context, index) {
                          items = allCarIDetailImages[index];
                          return items == ""
                              ? Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/taxinet_cab.png"),
                                  )),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 250,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(items),
                                      )),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            Text("${index + 1}"),
                                            const Text("/"),
                                            Text(allCarIDetailImages.length
                                                .toString()),
                                          ],
                                        ))
                                  ],
                                );
                        }),
                  ),
                  //   car details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₵$price",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(drive_type,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Description"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Engine Type:"),
                        Text(engine_type),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Location:"),
                        Text(location),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Millage:"),
                        Text(milage),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Interior Color:"),
                        Text(interior_color),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Exterior Color:"),
                        Text(exterior_color),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Transmission:"),
                        Text(transmission),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                  // const Divider(),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 8.0, left: 8, right: 8, bottom: 40),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(16),
                  //         color: primaryYellow),
                  //     height: size.height * 0.06,
                  //     width: size.width * 0.6,
                  //     child: RawMaterialButton(
                  //       onPressed: () {
                  //         Get.to(() => RequestDriveAndPay(
                  //             id: detailId, drive_type: drive_type));
                  //       },
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(8)),
                  //       elevation: 8,
                  //       fillColor: primaryYellow,
                  //       child: const Text(
                  //         "Request More Info",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //             color: defaultTextColor1),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
