import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:taxinet/screens/showroom/showroom.dart';

import '../../screens/homepage.dart';
import '../../screens/login/loginview.dart';
import '../../statics/appcolors.dart';

class MyRegistrationController extends GetxController {
  late List allUsers = [];

  late List allEmails = [];
  late List allUsernames = [];
  late List allPhoneNumbers = [];
  late List allFullNames = [];
  bool isLoading = false;
  bool isPosting = false;

  Future<void> registerUser(String uname, String email, String fName,
      String phoneNumber, String uPassword, String uRePassword) async {
    const loginUrl = "https://taxinetghana.xyz/auth/users/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": uname,
      "email": email,
      "full_name": fName,
      "phone_number": phoneNumber,
      "password": uPassword,
      "re_password": uRePassword
    });

    if (response.statusCode == 201) {
      isPosting = false;
      Get.offAll(() => const NewLogin());
    } else {
      Get.snackbar("Error 😢", response.body.toString(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return;
    }
  }

  Future<void> getAllUsers() async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/users/users/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allUsers = jsonData;
        for (var i in allUsers) {
          if (!allEmails.contains(i['email'])) {
            allEmails.add(i['email']);
          }
          if (!allUsernames.contains(i['username'])) {
            allUsernames.add(i['username']);
          }
          if (!allPhoneNumbers.contains(i['phone_number'])) {
            allPhoneNumbers.add(i['phone_number']);
          }
          if (!allPhoneNumbers.contains(i['allFullNames'])) {
            allPhoneNumbers.add(i['allFullNames']);
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

  Future<void> updateUser(String uname, String email, String phoneNumber,
      String id, String token) async {
    final updateUrl = "https://f-bazaar.com/users/user/$id/update/";
    final myLogin = Uri.parse(updateUrl);

    http.Response response = await http.put(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    }, body: {
      "username": uname,
      "email": email,
      "phone": phoneNumber,
    });

    if (response.statusCode == 200) {
      isPosting = false;
      Get.snackbar("Success", "Your account was updated successfully.",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: defaultYellow,
          duration: const Duration(seconds: 5));
      Get.offAll(() => const Showroom());
    } else {
      Get.snackbar("Error 😢", "Something went wrong",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return;
    }
  }
}
