import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import 'package:http/http.dart' as http;

import '../homepage.dart';

class RequestPayAndDrive extends StatefulWidget {
  final id;
  final drive_type;
  const RequestPayAndDrive(
      {super.key, required this.id, required this.drive_type});

  @override
  State<RequestPayAndDrive> createState() =>
      _RequestPayAndDriveState(id: this.id, drive_type: this.drive_type);
}

class _RequestPayAndDriveState extends State<RequestPayAndDrive> {
  final id;
  final drive_type;
  _RequestPayAndDriveState({required this.id, required this.drive_type});

  var uToken = "";
  final storage = GetStorage();

  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  final TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  late final TextEditingController pickUpDateController;
  late final TextEditingController dropOffDateController;
  bool isPosting = false;

  Future<void> requestDriveAndPay() async {
    final requestUrl =
        "https://taxinetghana.xyz/pay_drive/request_pay_and_drive/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "drive_type": drive_type,
      "pick_up_date": pickUpDateController.text,
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success 😀", "request sent.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow,
          colorText: defaultTextColor1);

      Get.offAll(() => const HomePage());
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      Get.snackbar("Sorry 😢", "something went wrong,please try again later.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }

  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    pickUpDateController = TextEditingController();
    dropOffDateController = TextEditingController();
  }

  @override
  void dispose() {
    pickUpDateController.dispose();
    dropOffDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Request Pay and Drive"),
          leading: const LeadingButton(),
        ),
        body: ListView(
          children: [
            SlideInUp(
              animate: true,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: pickUpDateController,
                          cursorColor: defaultBlack,
                          cursorRadius: const Radius.elliptical(10, 10),
                          cursorWidth: 10,
                          readOnly: true,
                          style: const TextStyle(color: defaultTextColor2),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.access_time,
                                  color: defaultBlack,
                                ),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2080))
                                      .then((value) {
                                    setState(() {
                                      _dateTime = value!;
                                      pickUpDateController.text = _dateTime
                                          .toString()
                                          .split("00")
                                          .first;
                                    });
                                  });
                                },
                              ),
                              labelText: "Pick up date",
                              labelStyle:
                                  const TextStyle(color: defaultTextColor2),
                              focusColor: defaultBlack,
                              fillColor: defaultBlack,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: defaultBlack, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Pick a date";
                            }
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 10.0),
                      //   child: TextFormField(
                      //     controller: dropOffDateController,
                      //     cursorColor: defaultBlack,
                      //     cursorRadius: const Radius.elliptical(10, 10),
                      //     cursorWidth: 10,
                      //     readOnly: true,
                      //     style: const TextStyle(color: defaultTextColor2),
                      //     decoration: InputDecoration(
                      //         suffixIcon: IconButton(
                      //           icon: const Icon(
                      //             Icons.event,
                      //             color: defaultBlack,
                      //           ),
                      //           onPressed: () {
                      //             showDatePicker(
                      //                     context: context,
                      //                     initialDate: DateTime.now(),
                      //                     firstDate: DateTime(1900),
                      //                     lastDate: DateTime(2080))
                      //                 .then((value) {
                      //               setState(() {
                      //                 _dateTime = value!;
                      //                 dropOffDateController.text = _dateTime
                      //                     .toString()
                      //                     .split("00")
                      //                     .first;
                      //               });
                      //             });
                      //           },
                      //         ),
                      //         labelText: "Drop Off date",
                      //         labelStyle:
                      //             const TextStyle(color: defaultTextColor2),
                      //         focusColor: defaultBlack,
                      //         fillColor: defaultBlack,
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: const BorderSide(
                      //                 color: defaultBlack, width: 2),
                      //             borderRadius: BorderRadius.circular(12)),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(12))),
                      //     keyboardType: TextInputType.text,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return "Pick date";
                      //       }
                      //     },
                      //   ),
                      // ),
                      isPosting
                          ? const LoadingUi()
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: primaryYellow),
                              height: size.height * 0.06,
                              width: size.width * 0.6,
                              child: RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    isPosting = true;
                                  });
                                  _startPosting();
                                  if (_formKey.currentState!.validate()) {
                                    requestDriveAndPay();
                                  } else {
                                    Get.snackbar(
                                        "Error", "Something went wrong",
                                        colorText: defaultTextColor1,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red);
                                    return;
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 8,
                                fillColor: primaryYellow,
                                child: const Text(
                                  "Request",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: defaultTextColor1),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
