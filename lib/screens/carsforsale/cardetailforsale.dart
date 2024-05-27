import 'dart:convert';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';

class CarDetailsForSale extends StatefulWidget {
  final id;
  const CarDetailsForSale({super.key, required this.id});

  @override
  State<CarDetailsForSale> createState() =>
      _CarDetailsForSaleState(id: this.id);
}

class _CarDetailsForSaleState extends State<CarDetailsForSale> {
  final id;
  _CarDetailsForSaleState({required this.id});
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
      location = jsonData['location'];
      milage = jsonData['milage'].toString();
      engine_type = jsonData['engine_type'];
      interior_color = jsonData['interior_color'];
      exterior_color = jsonData['exterior_color'];
      vin = jsonData['vin'];
      car_id = jsonData['car_id'];
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

  bool isPosting = false;

  Future<void> requestToBuy() async {
    final requestUrl = "https://taxinetghana.xyz/car_sales/request_to_buy/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      // "pick_up_date": pickUpDateController.text,
      // "drop_off_date": dropOffDateController.text,
    });
    if (response.statusCode == 201) {
      Get.snackbar(
          "Success 😀", "request sent.An agent will give you a call soon.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow,
          colorText: defaultTextColor1);

      Get.offAll(() => const HomePage());
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      Get.snackbar("Sorry 😢", "something went wrong,please try again later.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }

  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
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
        title: const Text("Car Detail"),
        leading: const LeadingButton(),
        actions: [
          isPosting
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    _startPosting();
                    requestToBuy();
                  },
                  child: const Text("More Info"),
                )
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
                    child: Text("₵$price",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
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
                        const Text("Milage:"),
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
                  const Divider(),
                  // isPosting
                  //     ? const LoadingUi()
                  //     : Padding(
                  //         padding: const EdgeInsets.only(
                  //             top: 8.0, left: 8, right: 8, bottom: 40),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(16),
                  //               color: primaryYellow),
                  //           height: size.height * 0.06,
                  //           width: size.width * 0.6,
                  //           child: RawMaterialButton(
                  //             onPressed: () {
                  //               _startPosting();
                  //               requestToBuy();
                  //             },
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(8)),
                  //             elevation: 8,
                  //             fillColor: primaryYellow,
                  //             child: const Text(
                  //               "Request More Info",
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 20,
                  //                   color: defaultTextColor1),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                ],
              ),
            ),
    );
  }
}
