import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxinet/screens/schedules/scheduleride.dart';

import '../../controllers/schedulecontroller/schedulecontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';

class MySchedules extends StatefulWidget {
  const MySchedules({super.key});

  @override
  State<MySchedules> createState() => _MySchedulesState();
}

class _MySchedulesState extends State<MySchedules> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Schedules"),
        leading: const LeadingButton(),
      ),
      body: GetBuilder<ScheduleController>(builder: (controller) {
        return SlideInUp(
          animate: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: controller.allMySchedules != null
                    ? controller.allMySchedules.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.allMySchedules[index];
                  return Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Type: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(items['schedule_type'])
                                ],
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Duration: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['schedule_duration'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Pick Up: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['pickup_location'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Drop Off: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['drop_off_location'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Time: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['pick_up_time'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['start_date'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Status: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['status'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                items['price'] != "0.00"
                                    ? Row(
                                        children: [
                                          const Text(
                                            "Price: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("₵${items['price']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red))
                                        ],
                                      )
                                    : Container(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['date_scheduled']
                                        .toString()
                                        .split("T")
                                        .first)
                                  ],
                                ),
                              ],
                            )),
                      ));
                }),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultYellow,
        onPressed: () {
          Get.to(() => const ScheduleRide());
        },
        child: const Icon(FontAwesomeIcons.plus, size: 26),
      ),
    );
  }
}
