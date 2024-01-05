import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taxinet/screens/ticketing/searchandrequestflight.dart';
import 'package:taxinet/screens/ticketing/showcalendar.dart';

import '../../widgets/backbutton.dart';
import 'allbookingrequests.dart';
import 'awaavailableflights.dart';
import 'confirmedbookings.dart';

class BookingComponent extends StatefulWidget {
  const BookingComponent({super.key});

  @override
  State<BookingComponent> createState() => _BookingComponentState();
}

class _BookingComponentState extends State<BookingComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Flight | Status"), leading: const LeadingButton()),
      body: SlideInUp(
        animate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const ShowCalender());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset("assets/images/airplane.png",
                                width: 130, height: 120),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text("Book a Flight",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ConfirmedBookings());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset("assets/images/tick.png",
                                width: 130, height: 120),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text("View my booking",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
