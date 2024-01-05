import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/payanddrive/payanddrivecontroller.dart';
import '../../widgets/backbutton.dart';
import '../payanddrive/car_detail_page.dart';

class PayAndDriveConfirmed extends StatefulWidget {
  const PayAndDriveConfirmed({super.key});

  @override
  State<PayAndDriveConfirmed> createState() => _PayAndDriveConfirmedState();
}

class _PayAndDriveConfirmedState extends State<PayAndDriveConfirmed> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Pay and Drive Active"),
          leading: const LeadingButton()),
      body: GetBuilder<PayAndDriveController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.allMyApprovedRequests != null
                ? controller.allMyApprovedRequests.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.allMyApprovedRequests[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => CarDetails(
                      id: controller.allMyApprovedRequests[index]['car']
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
