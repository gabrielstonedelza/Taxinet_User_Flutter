import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../statics/appcolors.dart';

class WalletController extends GetxController {
  bool isLoading = true;
  late List myWalletDetails = [];
  late List allUpdatedWalletDetails = [];
  late String myWalletID = "";
  late String walletUser = "";
  late double myWalletAmount = 0.0;
  late String userPhone = "";
  late String walletUserFullName = "";

  Future<void> getMyWallet(String token) async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/wallets/get_my_wallet/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        myWalletDetails = jsonData;
        for (var i in myWalletDetails) {
          myWalletID = i['id'].toString();
          walletUser = i['user'].toString();
          myWalletAmount = i['amount'];
          userPhone = i['get_user_phone'];
          walletUserFullName = i['get_full_name'];
        }
        print(response.body);
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

  Future<void> getMyUpdatedWallet(String token) async {
    try {
      isLoading = true;

      const profileLink =
          "https://taxinetghana.xyz/wallets/get_my_updated_wallet/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allUpdatedWalletDetails = jsonData;
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

  Future<void> updateUserWallet(
      String token, String walletId, String amount, String user) async {
    final updateUrl =
        "https://f-bazaar.com/wallets/wallet/$walletId/$amount/update/";
    final myLogin = Uri.parse(updateUrl);

    http.Response response = await http.put(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    }, body: {
      "id": walletId,
      "user": user,
      "amount": amount,
    });

    if (response.statusCode == 200) {
    } else {
      Get.snackbar("Error 😢", "Something went wrong",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return;
    }
  }

  Future<void> addToUpdatedWallets(
      String token, String walletId, String amount) async {
    final loginUrl = "https://taxinetghana.xyz/wallets/wallet/$walletId/add/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    }, body: {
      "wallet": walletId,
      "amount": amount,
    });

    if (response.statusCode == 201) {
    } else {
      Get.snackbar("Error 😢", "something happened,please try again later",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return;
    }
  }
}
