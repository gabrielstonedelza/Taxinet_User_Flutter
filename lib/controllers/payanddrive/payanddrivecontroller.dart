import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PayAndDriveController extends GetxController {
  bool isLoading = true;
  late List allPayAndDriveRequests = [];
  late List allMyApprovedRequests = [];
  bool hasExpired = false;
  late String expired = "";
  late String month = "";
  late String year = "";
  late String day = "";
  late String car = "";
  late String driveType = "";
  late String getExpirationDate = "";
  late String getPickUpDate = "";
  late String expirationDate = "";
  late String approvedId = "";
  late String usersPhone = "";
  late double dailyAmount = 0.0;

  String Api_Key =
      "o!jd!bi38nicfmu707d6tak_!dkmscxgph5vme3o!gounvm_eniub9z65@#dsf_0";

  Future<void> sendExpirationWarning(
      String userMessage, String senderId) async {
    const url =
        'https://sms.nalosolutions.com/smsbackend/Resl_Nalo/send-message/';
    String num = usersPhone.replaceFirst("0", '+233');
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

  String today = DateTime.now().toString().split(" ").first;

  Future<void> getAllMyPayAndDriveRequests(String token) async {
    try {
      isLoading = true;
      const profileLink =
          "https://taxinetghana.xyz/pay_drive/get_my_pay_and_drive_requests/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allPayAndDriveRequests = jsonData;
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

  Future<void> getAllMyApprovedRequests(String token) async {
    try {
      isLoading = true;
      const profileLink =
          "https://taxinetghana.xyz/pay_drive/get_all_my_approved_pay_and_drive/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allMyApprovedRequests = jsonData;
        for (var i in allMyApprovedRequests) {
          expired = i['expired'].toString();
          approvedId = i['id'].toString();
          usersPhone = i['get_phone_number'];
          dailyAmount = i['get_daily_amount'];
          car = i['get_car_pic'];
          getExpirationDate = i['get_drop_off_date'];
          getPickUpDate = i['pick_up_date'];
          month = getExpirationDate.substring(0,2);
          day = getExpirationDate.substring(3,5);
          year = getExpirationDate.substring(6);
          expirationDate = "$year-$month-$day";
        }

        if(today == expirationDate && expired == "false"){
          updateConfirmedRental(approvedId,token);
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
  Future<void> updateConfirmedRental(String id, String token) async {
    final updateUrl = "https://taxinetghana.xyz/pay_drive/update_approve_pay_drive/$id/";
    final myLogin = Uri.parse(updateUrl);

    http.Response response = await http.put(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    }, body: {
      "expired": "True",
    });

    if (response.statusCode == 200) {
      sendExpirationWarning("Hi, your active rental period ends today,please make sure to return the vehicle by 12pm or the vehicle will be locked.Please make sure to comply thanks.","Taxinet");
    }
  }
}
