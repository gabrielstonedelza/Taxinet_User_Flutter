import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxinet/screens/ticketing/requestbooking.dart';
import 'package:taxinet/statics/appcolors.dart';
import '../../controllers/ticketing/ticketingcontroller.dart';
import '../../widgets/backbutton.dart';

class AllAvailableFlightForAwa extends StatefulWidget {
  const AllAvailableFlightForAwa({super.key});

  @override
  State<AllAvailableFlightForAwa> createState() =>
      _AllAvailableFlightForAwaState();
}

class _AllAvailableFlightForAwaState extends State<AllAvailableFlightForAwa> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Available Flights"),
          leading: const LeadingButton(),
        ),
        body: GetBuilder<TicketingController>(builder: (controller) {
          return SlideInUp(
            animate: true,
            child: ListView.builder(
                itemCount: controller.availableFlightForAwa != null
                    ? controller.availableFlightForAwa.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.availableFlightForAwa[index];
                  return Card(
                    color: const Color(0xFFDF2025),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => RequestBooking(
                              flightId: controller.availableFlightForAwa[index]
                                      ['id']
                                  .toString(),
                              flightName: controller
                                  .availableFlightForAwa[index]['airline'],
                            ));
                      },
                      trailing: Image.asset("assets/images/awa.png",
                          width: 30, height: 30),
                      leading: Image.asset("assets/images/airplane-ticket.png",
                          width: 30, height: 30),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(items['airline'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 23)),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Flight Type: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['flight_type'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Depart Airport: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['departure_airport'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Arrival Airport: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['arrival_airport'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Depart Date: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['departure_date'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Depart Time: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['departure_time'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Flight Duration: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(items['flight_duration'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),

                          // items['flight_type'] != "One Way"
                          //     ? Column(
                          //         children: [
                          //           Row(
                          //             children: [
                          //               const Padding(
                          //                 padding: EdgeInsets.only(bottom: 8.0),
                          //                 child: Text("Return Date: ",
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white)),
                          //               ),
                          //               Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     bottom: 8.0),
                          //                 child: Text(items['returning_date'],
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white)),
                          //               ),
                          //             ],
                          //           ),
                          //           Row(
                          //             children: [
                          //               const Padding(
                          //                 padding: EdgeInsets.only(bottom: 8.0),
                          //                 child: Text("Return Time: ",
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white)),
                          //               ),
                          //               Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     bottom: 8.0),
                          //                 child: Text(items['returning_time'],
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white)),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
                          // Row(
                          //   children: [
                          //     const Padding(
                          //       padding: EdgeInsets.only(bottom: 8.0),
                          //       child: Text("Status: ",
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.white)),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.only(bottom: 8.0),
                          //       child: Text(items['flight_booked'],
                          //           style: const TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.white)),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Date Added: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                    items['date_added']
                                        .toString()
                                        .split("T")
                                        .first,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("Price: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("₵${items['price']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultYellow,
                                        fontSize: 20)),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text("Tap to request this booking",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }));
  }
}
