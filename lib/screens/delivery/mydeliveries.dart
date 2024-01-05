import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxinet/screens/delivery/requestdelivery.dart';

import '../../controllers/deliveries/deliveriescontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';

class MyDeliveries extends StatefulWidget {
  const MyDeliveries({super.key});

  @override
  State<MyDeliveries> createState() => _MyDeliveriesState();
}

class _MyDeliveriesState extends State<MyDeliveries> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Deliveries"),
        leading: const LeadingButton(),
      ),
      body: GetBuilder<DeliveryController>(builder: (controller) {
        return SlideInUp(
          animate: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: controller.allMyDeliveries != null
                    ? controller.allMyDeliveries.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.allMyDeliveries[index];
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
                                    "Vehicle Type: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(items['delivery_truck'])
                                ],
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Pick up date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['pick_up_date'])
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      "Delivery date: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(items['delivery_date'])
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
                                    Text(items['date_requested']
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
          Get.to(() => const RequestDelivery());
        },
        child: const Icon(FontAwesomeIcons.plus, size: 26),
      ),
    );
  }
}
