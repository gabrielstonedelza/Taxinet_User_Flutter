import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:taxinet/screens/homepage.dart';
import 'package:taxinet/statics/appcolors.dart';
import 'package:taxinet/widgets/loadingui.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/containerui.dart';

class AllAvailableFlightsForPassionAir extends StatefulWidget {
  final departDate;
  final airline;
  const AllAvailableFlightsForPassionAir(
      {super.key, required this.departDate, required this.airline});

  @override
  State<AllAvailableFlightsForPassionAir> createState() =>
      _AllAvailableFlightsForPassionAirState(
          departDate: this.departDate, airline: this.airline);
}

class _AllAvailableFlightsForPassionAirState
    extends State<AllAvailableFlightsForPassionAir> {
  final departDate;
  final airline;
  _AllAvailableFlightsForPassionAirState(
      {required this.departDate, required this.airline});
  late String uToken = "";
  final storage = GetStorage();
  var items;
  bool isLoading = true;
  late List availableFlights = [];

  Future<void> searchFlight() async {
    final url =
        "https://taxinetghana.xyz/ticketing/search_flight/$departDate/$airline/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      availableFlights = json.decode(jsonData);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> requestBooking(String flightId) async {
    final requestUrl =
        "https://taxinetghana.xyz/ticketing/request_flight/$flightId/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "flight": flightId,
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success 😀", "request sent.An agent will call you shortly",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    searchFlight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Available Flights"),
          leading: const LeadingButton(),
        ),
        body: isLoading
            ? const LoadingUi()
            : SlideInUp(
                animate: true,
                child: ListView.builder(
                    itemCount:
                        availableFlights != null ? availableFlights.length : 0,
                    itemBuilder: (context, index) {
                      items = availableFlights[index];
                      return GestureDetector(
                        onTap: () {
                          Get.snackbar("Please wait", "sending your request",
                              duration: const Duration(seconds: 5),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: primaryYellow,
                              colorText: defaultTextColor1);
                          requestBooking(
                              availableFlights[index]['id'].toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF526799),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(21),
                                          topRight: Radius.circular(21))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    items['departure_airport']
                                                        .toString()
                                                        .split(" (")
                                                        .last
                                                        .split(")")
                                                        .first,
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Row(
                                                  children: [
                                                    const ContainerUi(),
                                                    const Text("-----",
                                                        style: TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Transform.rotate(
                                                      angle: 1.5,
                                                      child: const Icon(
                                                          Icons
                                                              .local_airport_rounded,
                                                          color:
                                                              defaultTextColor1),
                                                    ),
                                                    const Text("-----",
                                                        style: TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const ContainerUi(),
                                                  ],
                                                ),
                                                Text(
                                                    items['arrival_airport']
                                                        .toString()
                                                        .split(" (")
                                                        .last
                                                        .split(")")
                                                        .first,
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    items['departure_airport']
                                                        .toString()
                                                        .split(" Airport")
                                                        .first
                                                        .split(" (KMS)")
                                                        .first,
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${items['flight_duration']} min",
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    items['arrival_airport']
                                                        .toString()
                                                        .split(" Airport")
                                                        .first
                                                        .split(" (ACC)")
                                                        .first,
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: const Color(0xFFF37B67),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 10,
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)))),
                                      ),
                                      Expanded(child: Divider()),
                                      SizedBox(
                                        height: 20,
                                        width: 10,
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)))),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFF37B67),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(21),
                                          bottomRight: Radius.circular(21))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text("Depart Date:",
                                                        style: TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        items['departure_date'],
                                                        style: const TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const Text("Depart Time:",
                                                        style: TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        items['departure_time'],
                                                        style: const TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }
}
