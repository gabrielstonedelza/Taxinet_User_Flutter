import 'dart:async';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:taxinet/screens/profile/profile.dart';
import 'package:taxinet/screens/wallet/wallets.dart';
import '../../controllers/carsales/carsalescontroller.dart';
import '../../controllers/daily_pay_for_drive_pay.dart';
import '../../controllers/deliveries/deliveriescontroller.dart';
import '../../controllers/driveandpay/drivaandpaycontroller.dart';
import '../../controllers/login/logincontroller.dart';
import '../../controllers/notifications/localnotificationcontroller.dart';
import '../../controllers/notifications/notificationcontroller.dart';
import '../../controllers/payanddrive/payanddrivecontroller.dart';
import '../../controllers/profile/profilecontroller.dart';
import '../../controllers/schedulecontroller/schedulecontroller.dart';
import '../../controllers/ticketing/ticketingcontroller.dart';
import '../../controllers/wallet/walletcontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/credit_cards_page.dart';
import '../../widgets/currentpaydrive.dart';
import '../available_cars.dart';
import '../notifications.dart';
import '../payanddrive/rental_detail_page.dart';
import '../schedules/myschedules.dart';
import '../ticketing/booking_component.dart';

class Showroom extends StatefulWidget {
  const Showroom({super.key});

  @override
  _ShowroomState createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {
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
  final DailyPayController dailyPayController = Get.find();
  double userWallet = 0.0;


  @override
  void initState() {
    super.initState();
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }

    scheduleTimers();
    // checkAndPay();
    userWallet = walletController.myWalletAmount;
  }

  void scheduleTimers() {
    checkAndPay();
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
      if (driveAndPayController.allMyApprovedRequests.isNotEmpty) {
        checkAndPay();
      }
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

  String Api_Key =
      "o!jd!bi38nicfmu707d6tak_!dkmscxgph5vme3o!gounvm_eniub9z65@#dsf_0";

  Future<void> sendDailyPaymentStatement(
      String userMessage, String senderId) async {
    const url =
        'https://sms.nalosolutions.com/smsbackend/Resl_Nalo/send-message/';
    String num = walletController.userPhone.replaceFirst("0", '+233');
    final myLink = Uri.parse(url);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "key": Api_Key,
      "msisdn": num,
      "message": userMessage,
      "sender_id": senderId,
    });
    if (response.statusCode == 200) {
      //all good
      if (kDebugMode) {
        print('Response is: ${response.body}');
      }
    } else {
      if (kDebugMode) {
        print('There was an issue sending message: ${response.body}');
      }
    }
  }
  double walletAmount = 0.0;
  String today = DateTime.now().toString().split(" ").first;

  void checkAndPay() {
    // check if the drop off date is not due and deduct the daily amount from the users wallet

    // if the date is due, lock car automatically


    DateTime now = DateTime.now();
    double amountAfterPay = userWallet - payAndDriveController.dailyAmount;
    if (now.hour == 0 && now.minute == 0 && now.second == 0) {
      if(today != payAndDriveController.expirationDate && payAndDriveController.expired != "false"){
        dailyPayController.makeDailyPayment(uToken, amountAfterPay.toString());
        sendDailyPaymentStatement(
            "GH${payAndDriveController.dailyAmount} was deducted from your wallet.Your remaining balance is GHC$amountAfterPay", "Taxinet");
      }
      if(today == payAndDriveController.expirationDate && payAndDriveController.expired == "false"){
        payAndDriveController.updateConfirmedRental(payAndDriveController.approvedId,uToken);
        sendDailyPaymentStatement("relay,1\%23#", "0244529353");
        sendDailyPaymentStatement(
            "Your requested rental period had expired and vehicle is locked, please call the admin for more information.",
            "Taxinet");
      }
      // if (userWallet < 600) {
      //   sendDailyPaymentStatement(
      //       "Your daily payment of GH${payAndDriveController.dailyAmount} couldn't go through because your wallet is less than 600",
      //       "Taxinet");
      //   sendDailyPaymentStatement(
      //       "Your vehicle is locked, please call the admin and make payment to unlock your vehicle.",
      //       "Taxinet");
      //   sendDailyPaymentStatement("relay,1\%23#", "0244529353");
      // } else {
      //   dailyPayController.makeDailyPayment(uToken, amountAfterPay.toString());
      //   sendDailyPaymentStatement(
      //       "GH${payAndDriveController.dailyAmount} was deducted from your wallet.", "Taxinet");
      // }
    }
  }

  var items;
  final _advancedDrawerController = AdvancedDrawerController();
  var item;
  var approvedItems;


  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GetBuilder<ProfileController>(
                builder: (controller) {
                  return Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 24.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: snackColor,
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      child: Center(
                          child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.profilePicture),
                        radius: 50,
                      )),
                    ),
                  );
                },
              ),
              GetBuilder<ProfileController>(
                builder: (controller) {
                  return Text(
                    controller.fullName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  );
                },
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Get.offAll(() => const Showroom());
                },
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const Profile());
                },
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const Wallet());
                },
                leading: const Icon(Icons.wallet),
                title: const Text('Wallet'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const MySchedules());
                },
                leading: const Icon(Icons.time_to_leave_outlined),
                title: const Text('Schedule Ride'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const BookingComponent());
                },
                leading: const Icon(Icons.flight),
                title: const Text('Ticketing'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const Notifications());
                },
                leading: const Icon(Icons.notifications_active),
                title: const Text('Notifications'),
              ),
              GetBuilder<LoginController>(builder: (loginController) {
                return ListTile(
                  onTap: () {
                    loginController.logoutUser(uToken);
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                );
              })

              // Spacer(),
              // DefaultTextStyle(
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Colors.white54,
              //   ),
              //   child: Container(
              //     margin: const EdgeInsets.symmetric(
              //       vertical: 16.0,
              //     ),
              //     child: const Text('Terms of Service | Privacy Policy'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Taxinet Ghana'),
              TextButton(
                child: const Text("All Cars",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                onPressed: (){
                  Get.to(() => const AvailableCars());
                },
              ),
            ],
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 220,
                        child: GetBuilder<CarSalesController>(
                          builder: (controller) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.allRentalCars != null
                                    ? controller.allRentalCars.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  items = controller.allRentalCars[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => RentCarDetails(
                                          id: controller.allRentalCars[index]
                                                  ['id']
                                              .toString()));
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
                                          right: index != null ? 12 : 0,
                                          left: index == 0 ? 12 : 0),
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
                                                tag: items['car_model'],
                                                child: Image.network(
                                                  items['get_car_pic'],
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Text(
                                            items['car_model'],
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            items['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8),
                child: GestureDetector(
                  onTap: (){
                    Get.to(() => const Wallet());
                  },
                  child: SizedBox(
                    child: GetBuilder<WalletController>(
                        builder: (controller) {
                          return ListView.builder(
                              itemCount:
                              controller.myWalletDetails != null
                                  ? controller.myWalletDetails.length
                                  : 0,
                              itemBuilder: (context, index) {
                                item = controller.myWalletDetails[index];

                                return CreditCardsPage(cardHolder: item['get_full_name'], walletAmount: item['amount']);
                              });
                        }),
                  ),
                ),
              ),
            ),
            payAndDriveController.allMyApprovedRequests.isNotEmpty ?
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: SizedBox(
                  child: GetBuilder<PayAndDriveController>(
                      builder: (controller) {
                        return ListView.builder(
                          itemCount: controller.allMyApprovedRequests != null ? controller.allMyApprovedRequests.length : 0,
                            itemBuilder: (context,index){
                            approvedItems = controller.allMyApprovedRequests[index];
                            return Card(
                              elevation: 4.0,
                              color: defaultYellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Container(
                                height: 200,
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(top:8.0),
                                      child: Center(child: Text("Active Rental ",style: TextStyle(fontWeight: FontWeight.bold),)),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/logo3.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(width: 120,),
                                        Expanded(
                                          child: Image.network(
                                            approvedItems['get_car_pic'],
                                            height: 100,
                                            width: 120,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              "Expiration Countdown",
                                              style: TextStyle(
                                                  color: Colors.black, fontSize:12, fontWeight: FontWeight.bold),
                                            ),
                                            CountDownText(
                                              due: DateTime.parse(approvedItems['get_drop_off_date']),
                                              finishedText: "Done",
                                              showLabel: true,
                                              longDateName: false,
                                              daysTextLong: " DAYS ",
                                              hoursTextLong: " HOURS ",
                                              minutesTextLong: " MINUTES ",
                                              secondsTextLong: " SECONDS ",
                                              style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );

                        });
                        // return CurrentPayDrive(car: controller.car, driveType: controller.driveType, dropOffDate: controller.getExpirationDate.toString(),pickupDate: controller.getPickUpDate.toString());
                      }),
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
