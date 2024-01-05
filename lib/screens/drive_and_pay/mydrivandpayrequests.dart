import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../controllers/driveandpay/drivaandpaycontroller.dart';
import '../../widgets/backbutton.dart';
import '../payanddrive/car_detail_page.dart';

class DriveAndPayRequests extends StatefulWidget {
  const DriveAndPayRequests({super.key});

  @override
  State<DriveAndPayRequests> createState() => _DriveAndPayRequestsState();
}

class _DriveAndPayRequestsState extends State<DriveAndPayRequests> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Drive and Pay Requests"),
          leading: const LeadingButton()),
      body: GetBuilder<DriveAndPayController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.allDriveAndPayRequests != null
                ? controller.allDriveAndPayRequests.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.allDriveAndPayRequests[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => CarDetails(
                      id: controller.allDriveAndPayRequests[index]['car']
                          .toString()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        items['get_car_pic'] == ""
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
                            : Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(items['get_car_pic']),
                                )),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(items['get_car_name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Row(
                            children: [
                              const Text("Status: "),
                              Text(items['request_approved'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
