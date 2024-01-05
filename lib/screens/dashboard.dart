import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxinet/screens/payanddrive/payanddrivecomponent.dart';
import 'package:taxinet/screens/schedules/myschedules.dart';
import 'package:taxinet/screens/ticketing/booking_component.dart';

import '../controllers/carsales/carsalescontroller.dart';
import '../controllers/deliveries/deliveriescontroller.dart';
import '../controllers/driveandpay/drivaandpaycontroller.dart';
import '../controllers/login/logincontroller.dart';
import 'package:get/get.dart';

import '../controllers/notifications/localnotificationcontroller.dart';
import '../controllers/notifications/notificationcontroller.dart';
import '../controllers/payanddrive/payanddrivecontroller.dart';
import '../controllers/profile/profilecontroller.dart';
import '../controllers/schedulecontroller/schedulecontroller.dart';
import '../controllers/ticketing/ticketingcontroller.dart';
import '../controllers/wallet/walletcontroller.dart';
import '../widgets/mycarouselslider.dart';
import 'carsforsale/allcarsforsale.dart';
import 'carsforsale/carsforrent.dart';
import 'drive_and_pay/driveandpaycomponent.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Timer _timer;
  String username = "";
  late String uToken = "";
  final storage = GetStorage();
  final LoginController loginController = Get.find();
  final NotificationController notificationController = Get.find();
  final ProfileController profileController = Get.find();
  final ScheduleController scheduleController = Get.find();
  final WalletController walletController = Get.find();
  final TicketingController ticketingController = Get.find();
  final DeliveryController deliveryController = Get.find();
  final CarSalesController carSalesController = Get.find();
  final DriveAndPayController driveAndPayController = Get.find();
  final PayAndDriveController payAndDriveController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    scheduleTimers();
  }

  void scheduleTimers() {
    notificationController.getAllTriggeredNotifications(uToken);
    notificationController.getAllUnReadNotifications(uToken);
    notificationController.getAllNotifications(uToken);
    profileController.getUserDetails(uToken);
    scheduleController.getAllMySchedules(uToken);
    walletController.getMyWallet(uToken);
    walletController.getMyUpdatedWallet(uToken);
    // ticketingController.getMyRequestedBookings(uToken);
    ticketingController.getMyBookings(uToken);
    // ticketingController.getAllAvailableFlightsForAwa(uToken);
    // ticketingController.getAllAvailableFlightsForPassion(uToken);
    deliveryController.getMyRequestedDeliveries(uToken);
    carSalesController.getAllRentals(uToken);
    carSalesController.getAllForSale(uToken);
    carSalesController.getAllRequestedCars(uToken);
    carSalesController.getAllApprovedPurchases(uToken);
    driveAndPayController.getAllMyDriveAndPayRequests(uToken);
    driveAndPayController.getAllMyApprovedRequests(uToken);
    payAndDriveController.getAllMyPayAndDriveRequests(uToken);
    payAndDriveController.getAllMyApprovedRequests(uToken);

    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      notificationController.getAllTriggeredNotifications(uToken);
      notificationController.getAllUnReadNotifications(uToken);
      notificationController.getAllNotifications(uToken);
      profileController.getUserDetails(uToken);
      scheduleController.getAllMySchedules(uToken);
      walletController.getMyWallet(uToken);
      walletController.getMyUpdatedWallet(uToken);
      // ticketingController.getMyRequestedBookings(uToken);
      ticketingController.getMyBookings(uToken);
      // ticketingController.getAllAvailableFlightsForAwa(uToken);
      // ticketingController.getAllAvailableFlightsForPassion(uToken);
      deliveryController.getMyRequestedDeliveries(uToken);
      carSalesController.getAllRentals(uToken);
      carSalesController.getAllForSale(uToken);
      carSalesController.getAllRequestedCars(uToken);
      carSalesController.getAllApprovedPurchases(uToken);
      payAndDriveController.getAllMyPayAndDriveRequests(uToken);
      payAndDriveController.getAllMyApprovedRequests(uToken);
      for (var i in notificationController.triggered) {
        LocalNotificationController().showNotifications(
          title: i['notification_title'],
          body: i['notification_message'],
        );
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      for (var e in notificationController.triggered) {
        notificationController.unTriggerNotifications(e["id"], uToken);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Taxinet",
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () {
                  loginController.logoutUser(uToken);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SlideInUp(
          animate: true,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const MyCarouselComponent(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const MySchedules());
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
                                    Image.asset("assets/images/schedule.png",
                                        width: 70, height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Schedule Ride",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const BookingComponent());
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
                                    Image.asset(
                                        "assets/images/ticket-flight.png",
                                        width: 70,
                                        height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Ticketing",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const AllCarsForRent());
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
                                    Image.asset("assets/images/car-rental.png",
                                        width: 70, height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Rent a Car",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const AllCarsForSale());
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
                                    Image.asset("assets/images/car-rental.png",
                                        width: 70, height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Buy your Car",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const DriveAndPayComponent());
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
                                        width: 70, height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Drive & Pay",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const PayAndDriveComponent());
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
                                        width: 70, height: 70),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Pay & Driver",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
