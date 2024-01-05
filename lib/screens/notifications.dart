import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import '../../statics/appcolors.dart';
import '../controllers/notifications/notificationcontroller.dart';
import 'carsforsale/allcarsforsale.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController notificationController = Get.find();
  final storage = GetStorage();
  late String uToken = "";

  @override
  void initState() {
    // TODO: implement initState
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    notificationController.updateReadNotification(uToken);
    super.initState();
  }

  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<NotificationController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.allNots != null ? controller.allNots.length : 0,
        itemBuilder: (BuildContext context, int index) {
          items = controller.allNots[index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  if (controller.allNots[index]['notification_title'] ==
                      "Vehicle Purchase Request Approved") {
                  } else if (controller.allNots[index]['notification_title'] ==
                      "New Vehicle Added") {
                    Get.to(() => const AllCarsForSale());
                  }
                },
                leading: const Icon(Icons.notifications),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          items['date_created'].toString().split("T").first),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("-"),
                    ),
                    Text(items['date_created']
                        .toString()
                        .split("T")
                        .last
                        .split(".")
                        .first),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(items['notification_message']),
                ),
              ),
            )),
          );
        },
      );
    }));
  }
}
