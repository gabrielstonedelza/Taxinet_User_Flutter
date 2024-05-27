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

class RequestDriveAndPay extends StatefulWidget {
  final id;
  final drive_type;
  final rent_type;
  const RequestDriveAndPay(
      {super.key,
      required this.id,
      required this.drive_type,
      required this.rent_type});

  @override
  State<RequestDriveAndPay> createState() => _RequestDriveAndPayState(
      id: this.id, drive_type: this.drive_type, rent_type: this.rent_type);
}

class _RequestDriveAndPayState extends State<RequestDriveAndPay> {
  final id;
  final drive_type;
  final rent_type;
  _RequestDriveAndPayState(
      {required this.id, required this.drive_type, required this.rent_type});

  var uToken = "";
  final storage = GetStorage();
  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  final TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  late final TextEditingController pickUpDateController;
  late final TextEditingController dropOffDateController;
  bool isPosting = false;
  late String deRentType = rent_type;
  var _currentSelectedDriveType = "Select Drive Type";
  List driveTypes = ["Select Drive Type", "Self Drive", "With Driver"];

  Future<void> requestDriveAndPay() async {
    final requestUrl =
        "https://taxinetghana.xyz/drive_pay/request_drive_and_pay/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "drive_type": _currentSelectedDriveType,
      "rent_type": rent_type,
      "pick_up_date": pickUpDateController.text,
      "drop_off_date": dropOffDateController.text,
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
          title: Text("Request $deRentType"),
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: const SizedBox(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              items: driveTypes.map((dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                _onDropDownItemSelectedDriveType(
                                    newValueSelected);
                              },
                              value: _currentSelectedDriveType,
                            ),
                          ),
                        ),
                      ),
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
                              labelText: "Tap on icon for pick up date",
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: dropOffDateController,
                          cursorColor: defaultBlack,
                          cursorRadius: const Radius.elliptical(10, 10),
                          cursorWidth: 10,
                          readOnly: true,
                          style: const TextStyle(color: defaultTextColor2),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.event,
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
                                      dropOffDateController.text = _dateTime
                                          .toString()
                                          .split("00")
                                          .first;
                                    });
                                  });
                                },
                              ),
                              labelText: "Tap on icon for Drop Off date",
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
                              return "Pick date";
                            }
                          },
                        ),
                      ),
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
                                  "Send",
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

  void _onDropDownItemSelectedDriveType(newValueSelected) {
    setState(() {
      _currentSelectedDriveType = newValueSelected;
    });
  }
}
