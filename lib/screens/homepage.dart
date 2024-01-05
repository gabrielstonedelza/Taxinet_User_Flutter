import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:taxinet/screens/profile/profile.dart';
import 'package:taxinet/screens/wallets.dart';
import '../controllers/login/logincontroller.dart';
import '../controllers/notifications/notificationcontroller.dart';
import '../controllers/profile/profilecontroller.dart';
import '../statics/appcolors.dart';
import 'dashboard.dart';
import 'information.dart';
import 'notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  final storage = GetStorage();
  var _currentIndex = 0;
  final LoginController controller = Get.find();
  final ProfileController profileController = Get.find();
  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Notifications(),
    Wallet(),
    Profile()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: defaultTextColor1,
        unselectedItemColor: muted,
        backgroundColor: defaultBlack,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: defaultTextColor1,
          ),

          /// notifications
          SalomonBottomBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                  badgeContent: GetBuilder<NotificationController>(
                      builder: (rController) {
                    return Text("${rController.notRead.length}",
                        style: const TextStyle(color: Colors.white));
                  }),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  child: const Icon(Icons.notifications_active)),
            ),
            title: const Text("Alerts"),
            activeIcon: const Icon(Icons.notifications),
            selectedColor: primaryYellow,
          ),
          // wallet
          SalomonBottomBarItem(
            icon: const Text("₵",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey)),
            title: const Text("Wallet"),
            selectedColor: defaultTextColor1,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: defaultTextColor1,
          ),
        ],
      ),
    );
  }
}
