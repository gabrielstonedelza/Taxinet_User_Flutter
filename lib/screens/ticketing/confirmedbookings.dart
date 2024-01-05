import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ticketing/ticketingcontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/containerui.dart';
import '../schedules/scheduleride.dart';

class ConfirmedBookings extends StatefulWidget {
  const ConfirmedBookings({super.key});

  @override
  State<ConfirmedBookings> createState() => _ConfirmedBookingsState();
}

class _ConfirmedBookingsState extends State<ConfirmedBookings> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Confirmed Bookings"),
          leading: const LeadingButton(),
        ),
        body: GetBuilder<TicketingController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.allMyBookings != null
                  ? controller.allMyBookings.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.allMyBookings[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
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
                                                    items['get_depart_airport']
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
                                                    items['get_arrival_airport']
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
                                                    items['get_depart_airport']
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
                                                    "${items['get_flight_duration']} min",
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    items['get_arrival_airport']
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
                                  color: const Color(0xFF526799),
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
                                      color: Color(0xFF526799),
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
                                                        items[
                                                            'get_depart_date'],
                                                        style: const TextStyle(
                                                            color:
                                                                defaultTextColor1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                Text(items['get_airline'],
                                                    style: const TextStyle(
                                                        color:
                                                            defaultTextColor1,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                        items[
                                                            'get_depart_time'],
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
                          controller.allMyBookings[index]['flight_type'] ==
                                  "Round Trip"
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.orangeAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(21),
                                                topRight: Radius.circular(21))),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          items['get_arrival_airport']
                                                              .toString()
                                                              .split(" (")
                                                              .last
                                                              .split(")")
                                                              .first,
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
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
                                                          items['get_depart_airport']
                                                              .toString()
                                                              .split(" (")
                                                              .last
                                                              .split(")")
                                                              .first,
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          items['get_arrival_airport']
                                                              .toString()
                                                              .split(" Airport")
                                                              .first
                                                              .split(" (KMS)")
                                                              .first,
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          "${items['get_flight_duration']} min",
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          items['get_depart_airport']
                                                              .toString()
                                                              .split(" Airport")
                                                              .first
                                                              .split(" (ACC)")
                                                              .first,
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.orangeAccent,
                                        child: const Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 10,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10)))),
                                            ),
                                            Expanded(child: Divider()),
                                            SizedBox(
                                              height: 20,
                                              width: 10,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.orangeAccent,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(21),
                                                bottomRight:
                                                    Radius.circular(21))),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Text(
                                                              "Return Date:",
                                                              style: TextStyle(
                                                                  color:
                                                                      defaultTextColor1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                              items[
                                                                  'returning_date'],
                                                              style: const TextStyle(
                                                                  color:
                                                                      defaultTextColor1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      Text(items['get_airline'],
                                                          style: const TextStyle(
                                                              color:
                                                                  defaultTextColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Column(
                                                        children: [
                                                          const Text(
                                                              "Return Time:",
                                                              style: TextStyle(
                                                                  color:
                                                                      defaultTextColor1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                              items[
                                                                  'returning_time'],
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
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ScheduleRide());
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Want pick up and drop off to the airport?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_forward_ios_sharp)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }));
  }
}
