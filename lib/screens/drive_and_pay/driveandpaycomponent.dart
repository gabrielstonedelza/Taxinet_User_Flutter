import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:get/get.dart';

import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../payanddrive/mypayanddriverequests.dart';
import 'confirmeddrivandpay.dart';
import 'mydrivandpayrequests.dart';

class DriveAndPayComponent extends StatefulWidget {
  const DriveAndPayComponent({super.key});

  @override
  State<DriveAndPayComponent> createState() => _DriveAndPayComponentState();
}

class _DriveAndPayComponentState extends State<DriveAndPayComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Drive and Pay"), leading: const LeadingButton()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideInUp(
            animate: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const DriveAndPayRequests());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/check-list.png",
                                  width: 50, height: 50),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Drive & Pay",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text("Requests",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ConfirmedDriveAndPay());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/check-list.png",
                                  width: 50, height: 50),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Drive & Pay",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text("Active",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
