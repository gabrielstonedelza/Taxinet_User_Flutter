
import 'package:flutter/material.dart';
import 'package:taxinet/controllers/carsales/carsalescontroller.dart';
import 'package:taxinet/screens/payanddrive/rental_detail_page.dart';

import '../widgets/backbutton.dart';
import 'package:get/get.dart';


class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  var items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Cars"),
        leading: const LeadingButton(),
      ),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: GetBuilder<CarSalesController>(builder:(controller){
                  return GridView.count(
                    physics: const BouncingScrollPhysics(),
                    childAspectRatio: 1 / 1.4,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: controller.allRentalCars.map((item) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => RentCarDetails(id:item['id']));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            margin: EdgeInsets.only(
                                right: item != null ? 12 : 0,
                                left: item == 0 ? 12 : 0),
                            width: 200,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 120,
                                  child: Center(
                                    child: Hero(
                                      tag: item['car_model'],
                                      child: Image.network(
                                        item['get_car_pic'],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  item['car_model'],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    }).toList(),
                  );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }

}