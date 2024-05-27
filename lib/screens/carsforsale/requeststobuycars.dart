import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/carsales/carsalescontroller.dart';
import '../../widgets/backbutton.dart';
import '../payanddrive/rental_detail_page.dart';

class MyRequestToBuyCars extends StatefulWidget {
  const MyRequestToBuyCars({super.key});

  @override
  State<MyRequestToBuyCars> createState() => _MyRequestToBuyCarsState();
}

class _MyRequestToBuyCarsState extends State<MyRequestToBuyCars> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Requests to buy"),
          leading: const LeadingButton()),
      body: GetBuilder<CarSalesController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.allRequestedToBuyCars != null
                ? controller.allRequestedToBuyCars.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.allRequestedToBuyCars[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => RentCarDetails(
                      id: controller.allRequestedToBuyCars[index]['car']
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
