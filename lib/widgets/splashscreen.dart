import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/login/loginview.dart';
import '../screens/showroom/showroom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
      setState(() {
        hasToken = true;
      });
    } else {
      setState(() {
        hasToken = false;
      });
    }
    if (hasToken) {
      Timer(
          const Duration(seconds: 9), () => Get.offAll(() => const Showroom()));
    } else {
      Timer(const Duration(seconds: 9),
              () => Get.offAll(() => const NewLogin()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/car_rental.gif"),
            const SizedBox(height: 35,),
            SlideInUp(
              animate: true,
              child: const Center(
                child: Text("Taxinet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
