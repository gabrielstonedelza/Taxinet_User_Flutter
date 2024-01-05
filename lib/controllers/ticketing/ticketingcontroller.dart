import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TicketingController extends GetxController {
  bool isLoading = true;
  late List allMyRequestedBookings = [];
  late List allMyBookings = [];
  late List availableFlightForPassionAir = [];
  late List availableFlightForAwa = [];

  // Future<void> getMyRequestedBookings(String token) async {
  //   try {
  //     isLoading = true;
  //
  //     const profileLink =
  //         "https://taxinetghana.xyz/ticketing/get_all_my_requested_flights/";
  //     var link = Uri.parse(profileLink);
  //     http.Response response = await http.get(link, headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "Authorization": "Token $token"
  //     });
  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //       allMyRequestedBookings = jsonData;
  //       update();
  //     } else {
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //     }
  //   } catch (e) {
  //     // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }

  Future<void> getMyBookings(String token) async {
    try {
      isLoading = true;

      const profileLink =
          "https://taxinetghana.xyz/ticketing/get_all_my_booked_flights/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allMyBookings = jsonData;
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

  // Future<void> getAllAvailableFlightsForAwa(String token) async {
  //   try {
  //     isLoading = true;
  //
  //     const profileLink =
  //         "https://taxinetghana.xyz/ticketing/get_available_flights_for_awa/";
  //     var link = Uri.parse(profileLink);
  //     http.Response response = await http.get(link, headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "Authorization": "Token $token"
  //     });
  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //       availableFlightForAwa = jsonData;
  //       update();
  //     } else {
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //     }
  //   } catch (e) {
  //     // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
  //
  // Future<void> getAllAvailableFlightsForPassion(String token) async {
  //   try {
  //     isLoading = true;
  //
  //     const profileLink =
  //         "https://taxinetghana.xyz/ticketing/get_available_flights_for_passion_air/";
  //     var link = Uri.parse(profileLink);
  //     http.Response response = await http.get(link, headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "Authorization": "Token $token"
  //     });
  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //       availableFlightForPassionAir = jsonData;
  //       update();
  //     } else {
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //     }
  //   } catch (e) {
  //     // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
