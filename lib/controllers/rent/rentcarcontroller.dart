import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RentCarController extends GetxController {
  bool isLoading = true;
  late List allMyRentDetails = [];
  late List allMyActiveRents = [];
  late Timer _timer;
  late String uToken = "";
  final storage = GetStorage();

  // @override
  // void onInit() {
  //   if (storage.read("token") != null) {
  //     uToken = storage.read("token");
  //   }
  //   getMyRents();
  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (storage.read("token") != null) {
  //       uToken = storage.read("token");
  //     }
  //     getMyRents();
  //   });
  //   super.onInit();
  // }

  Future<void> getMyRents() async {
    try {
      isLoading = true;

      const profileLink =
          "https://taxinetghana.xyz/drive_pay/get_my_drive_and_pay_requests/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allMyRentDetails = jsonData;
        for (var i in allMyRentDetails) {
          if (i['rent_status'] == "Booked" && !allMyActiveRents.contains(i)) {
            allMyActiveRents.add(i);
          }
        }
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }
}
