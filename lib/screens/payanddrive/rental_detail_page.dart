import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:taxinet/screens/payanddrive/requestpayanddrive.dart';
import 'package:taxinet/statics/appcolors.dart';
import '../../controllers/payanddrive/payanddrivecontroller.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import '../constants.dart';

class RentCarDetails extends StatefulWidget {
  final id;
  const RentCarDetails({super.key, required this.id});

  @override
  State<RentCarDetails> createState() => _RentCarDetailsState(id: this.id);
}

class _RentCarDetailsState extends State<RentCarDetails> {
  final id;
  _RentCarDetailsState({required this.id});
  final PayAndDriveController payAndDriveController = Get.find();
  bool isLoading = true;
  final storage = GetStorage();
  late String uToken = "";
  late List allCarIDetail = [];
  late List allCarIDetailImages = [];
  late String detailId = "";
  late String name = "";
  late String engineType = "";
  late String seater = "";
  late String description = "";
  late String picture = "";
  late String carModel = "";
  late String transmission = "";
  late String color = "";
  late String driveType = "";
  late String outsideKsi = "";
  late String justKsi = "";
  late String k200 = "";
  late String k300 = "";
  late String k400 = "";
  late String k500 = "";
  late String k600 = "";
  late String kk200 = "";
  var items;
  int _currentImage = 0;


  Future<void> getCarDetails() async {
    final profileLink = "https://taxinetghana.xyz/for_rent/vehicle/$id/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      driveType = jsonData['drive_type'];
      outsideKsi = jsonData['outside_ksi'].toString();
      justKsi = jsonData['just_ksi'].toString();
      detailId = jsonData['id'].toString();
      name = jsonData['name'];
      k200 = jsonData['k200'];
      k300 = jsonData['k300'];
      k400 = jsonData['k400'];
      k500 = jsonData['k500'];
      k600 = jsonData['k600'];
      kk200 = jsonData['kk200'];
      engineType = jsonData['engine_type'];
      carModel = jsonData['car_model'];
      transmission = jsonData['transmission'];
      color = jsonData['color'];
      seater = jsonData['seater'].toString();
      description = jsonData['description'];
      picture = jsonData['picture'];
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getCarImages() async {
    final profileLink =
        "https://taxinetghana.xyz/for_rent/get_all_vehicles_for_rent_images/$id/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allCarIDetail = jsonData;
      for (var i in allCarIDetail) {
        if (!allCarIDetailImages.contains(i['get_car_pic'])) {
          allCarIDetailImages.add(i['get_car_pic']);
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  @override
  void initState() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    getCarDetails();
    getCarImages();
    super.initState();
  }
  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < allCarIDetailImages.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text("$name $carModel",style: const TextStyle(color:Colors.black),),
        leading: const LeadingButton(),
        // actions: [
        //   TextButton(
        //     onPressed: (){
        //       if(payAndDriveController.allMyApprovedRequests.isNotEmpty){
        //         Get.snackbar("Request Error", "Please complete your current rental period before requesting another.Thank you.",
        //             colorText: Colors.white,
        //             snackPosition: SnackPosition.BOTTOM,
        //             backgroundColor: Colors.red,
        //             duration: const Duration(seconds: 5));
        //       }
        //       else{
        //         Get.to(()=> RequestPayAndDrive(id: detailId));
        //       }
        //     },
        //     child: const Text("Request Call back",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w900),),
        //   )
        // ],
      ),
      body: isLoading
          ? const LoadingUi()
          : SlideInUp(
              animate: true,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: PageView(
                                physics: const BouncingScrollPhysics(),
                                onPageChanged: (int page) {
                                  setState(() {
                                    _currentImage = page;
                                  });
                                },
                                children: allCarIDetailImages.map((url) {

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Hero(
                                      tag: carModel,
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            allCarIDetailImages.length > 1
                                ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              height: 30,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: buildPageIndicator(),
                              ),
                            )
                                : Container(),
                            justKsi == "false" ?  const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child:Text("Outside Kumasi Charges",style: TextStyle(fontWeight: FontWeight.bold),)
                              ),
                            ) : Container(),
                            justKsi == "false" ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 16,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: ListView(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        buildOutSideKumasi("200 KM",k200),
                                        buildOutSideKumasi("300 KM",k300),
                                        buildOutSideKumasi("400 KM",k400),
                                        buildOutSideKumasi("500 KM",k500),
                                        buildOutSideKumasi("600 KM",k600),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(
                              "SPECIFICATIONS",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildSpecificationCar("Drive Type", driveType),
                                // buildSpecificationCar("Color", color),
                                buildSpecificationCar("Transmission", transmission),
                                buildSpecificationCar("Seat", seater),
                                buildSpecificationCar("Engine",engineType),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Within Kumasi",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      kk200,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "daily",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                if(payAndDriveController.allMyApprovedRequests.isNotEmpty){
                  Get.snackbar("Request Error", "Please complete your current rental period before requesting another.Thank you.",
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 5));
                }
                else{
                  Get.to(()=> RequestPayAndDrive(id: detailId,driveType:driveType));
                }
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: defaultYellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Book this car",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOutSideKumasi(String kilometers, String data) {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            child: Text(
              kilometers,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpecificationCar(String title, String data) {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
