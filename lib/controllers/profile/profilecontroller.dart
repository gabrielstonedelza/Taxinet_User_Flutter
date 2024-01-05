import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  bool isLoading = false;
  List profileDetails = [];
  late String userId = "";
  late String email = "";
  final storage = GetStorage();
  late String userName = "";
  late String fullName = "";
  late String phoneNumber = "";
  late String profilePicture = "";
  late String userApproved = "";
  late String driversTrackerSim = "";

  Future<void> getUserDetails(String token) async {
    try {
      isLoading = true;

      const profileLink = "https://taxinetghana.xyz/profiles/profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        profileDetails = jsonData;
        for (var i in profileDetails) {
          userId = i['user'].toString();
          userName = i['get_username'];
          fullName = i['get_users_full_name'];
          phoneNumber = i['get_users_phone_number'];
          email = i['get_users_email'];
          profilePicture = i['user_profile_pic'];
          driversTrackerSim = i['get_user_tracker_sim'];
          userApproved = i['get_user_approved'];
        }
        storage.write("profile_pic", profilePicture);
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
