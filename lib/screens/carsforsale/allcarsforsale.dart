import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:taxinet/screens/carsforsale/requeststobuycars.dart';

import '../../controllers/carsales/carsalescontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import 'cardetailforsale.dart';

class AllCarsForSale extends StatefulWidget {
  const AllCarsForSale({super.key});

  @override
  State<AllCarsForSale> createState() => _AllCarsForSaleState();
}

class _AllCarsForSaleState extends State<AllCarsForSale> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Pick your taste"), leading: const LeadingButton()),
      body: GetBuilder<CarSalesController>(builder: (controller) {
        return SlideInUp(
          animate: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: controller.allForSaleCars != null
                    ? controller.allForSaleCars.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.allForSaleCars[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => CarDetailsForSale(
                          id: controller.allForSaleCars[index]['id']
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(items['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text("₵${items['price']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  const Icon(FontAwesomeIcons.gaugeSimpleHigh),
                                  const SizedBox(width: 10),
                                  Text(items['milage'].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  const Icon(FontAwesomeIcons.locationPin),
                                  const SizedBox(width: 10),
                                  Text(items['location'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.carRear),
                                  SizedBox(width: 10),
                                  Text("Foreign Use",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }
}
