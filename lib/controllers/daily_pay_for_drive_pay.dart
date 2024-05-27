import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:taxinet/controllers/wallet/walletcontroller.dart';

class DailyPayController extends GetxController {
  final WalletController walletController = Get.find();

  Future<void> makeDailyPayment(String token, String amount) async {
    const loginUrl =
        "https://taxinetghana.xyz/drive_pay/add_to_drive_and_pay_daily/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    }, body: {
      "amount": amount,
    });

    if (response.statusCode == 201) {
      walletController.addToUpdatedWallets(
          token, walletController.myWalletID, amount);
      walletController.updateUserWallet(token, walletController.myWalletID,
          amount, walletController.walletUser);
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
