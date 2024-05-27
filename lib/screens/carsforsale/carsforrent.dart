import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/carsales/carsalescontroller.dart';
import '../../widgets/backbutton.dart';
import '../payanddrive/rental_detail_page.dart';

class AllCarsForRent extends StatefulWidget {
  const AllCarsForRent({super.key});

  @override
  State<AllCarsForRent> createState() => _AllCarsForRentState();
}

class _AllCarsForRentState extends State<AllCarsForRent> {
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
                itemCount: controller.allRentalCars != null
                    ? controller.allRentalCars.length
                    : 0,
                itemBuilder: (context, index) {
                  items = controller.allRentalCars[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => RentCarDetails(
                          id: controller.allRentalCars[index]['id']
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
                                      fontSize: 17)),
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
