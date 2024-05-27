import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/backbutton.dart';
import '../drive_and_pay/confirmeddrivandpay.dart';
import '../drive_and_pay/mydrivandpayrequests.dart';
import '../payanddrive/mypayanddriverequests.dart';
import 'confirmedpayanddrive.dart';

class PayAndDriveComponent extends StatefulWidget {
  const PayAndDriveComponent({super.key});

  @override
  State<PayAndDriveComponent> createState() => _PayAndDriveComponentState();
}

class _PayAndDriveComponentState extends State<PayAndDriveComponent> {
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
                    // Get.to(() => const PayAndDriveRequests());
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
                                child: Text("Drive and Pay",
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
                    // Get.to(() => const PayAndDriveConfirmed());
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
                                child: Text("Active",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const Text("Drive and pay",
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
