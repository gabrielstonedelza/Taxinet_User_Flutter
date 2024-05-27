import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:taxinet/screens/showroom/showroom.dart';

import '../../screens/homepage.dart';
import '../../screens/login/loginview.dart';
import '../../statics/appcolors.dart';

class LoginController extends GetxController {
  final client = http.Client();
  final storage = GetStorage();
  bool isLoggingIn = false;
  bool isUser = false;
  late int oTP = 0;
  late String myToken = "";
  late String agentUsername = "";
  bool isPosting = false;
  String errorMessage = "";
  bool isLoading = false;

  Future<void> loginUser(String username, String password) async {
    const loginUrl = "https://taxinetghana.xyz/auth/token/login/";
    final myLink = Uri.parse(loginUrl);
    http.Response response = await client.post(myLink,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      final resBody = response.body;
      var jsonData = jsonDecode(resBody);
      var userToken = jsonData['auth_token'];
      agentUsername = username;
      storage.write("token", userToken);
      storage.write("username", username);
      isLoggingIn = false;
      isUser = true;
      isPosting = false;
      Get.offAll(() => const Showroom());
    } else {
      Get.snackbar("Sorry 😢", "invalid details",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning,
          colorText: defaultTextColor1);
      isLoggingIn = false;
      isUser = false;
      storage.remove("token");
      storage.remove("username");
    }
  }

  Future<void> logoutUser(String token) async {
    storage.remove("token");
    Get.offAll(() => const NewLogin());
    const logoutUrl = "https://taxinetghana.xyz/auth/token/logout/";
    final myLink = Uri.parse(logoutUrl);
    http.Response response = await http.post(myLink, headers: {
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      Get.snackbar("Success", "You were logged out",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow);
      storage.remove("token");
      Get.offAll(() => const NewLogin());
    }
  }
}
