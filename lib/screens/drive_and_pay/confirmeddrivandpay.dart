import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/driveandpay/drivaandpaycontroller.dart';
import '../../controllers/profile/profilecontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../sendsms.dart';
import 'addinventory.dart';

class ConfirmedDriveAndPay extends StatefulWidget {
  const ConfirmedDriveAndPay({super.key});

  @override
  State<ConfirmedDriveAndPay> createState() => _ConfirmedDriveAndPayState();
}

class _ConfirmedDriveAndPayState extends State<ConfirmedDriveAndPay> {
  final SendSmsController sendSms = SendSmsController();
  final ProfileController profileController = Get.find();
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Drive and Pay Active"),
          leading: const LeadingButton()),
      body: GetBuilder<DriveAndPayController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.allMyApprovedRequests != null
                ? controller.allMyApprovedRequests.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.allMyApprovedRequests[index];
              return GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(items['get_car_name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23)),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Drive Type: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(items['get_drive_type'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Period: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(items['get_period'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text("Drop Off Date: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  items['get_drop_off_date']
                                      .toString()
                                      .split("T")
                                      .first,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                        // const Divider(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     RawMaterialButton(
                        //       onPressed: () {
                        //         if (kDebugMode) {
                        //           print(profileController.driversTrackerSim);
                        //         }
                        //         String driversPhone =
                        //             profileController.phoneNumber;
                        //         driversPhone =
                        //             driversPhone.replaceFirst("0", '+233');
                        //         // function to lock car
                        //         String trackerSim =
                        //             profileController.driversTrackerSim;
                        //         trackerSim =
                        //             trackerSim.replaceFirst("0", '+233');
                        //         sendSms.sendMySms(driversPhone, "Taxinet",
                        //             "Attention!,your car is locked.");
                        //         sendSms.sendMySms(
                        //             trackerSim, "0244529353", "relay,1\%23#");
                        //       },
                        //       // child: const Text("Send"),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(8)),
                        //       elevation: 8,
                        //       fillColor: buttonColor,
                        //       splashColor: primaryYellow,
                        //       child: const Text(
                        //         "Lock Car",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 15,
                        //             color: Colors.white),
                        //       ),
                        //     ),
                        //     RawMaterialButton(
                        //       onPressed: () {
                        //         Get.to(() => const AddInventory());
                        //       },
                        //       // child: const Text("Send"),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(8)),
                        //       elevation: 8,
                        //       fillColor: buttonColor,
                        //       splashColor: primaryYellow,
                        //       child: const Padding(
                        //         padding: EdgeInsets.all(8.0),
                        //         child: Text(
                        //           "Add Inventory",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //               color: Colors.white),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
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
