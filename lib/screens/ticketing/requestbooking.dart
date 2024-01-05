import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxinet/widgets/backbutton.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../statics/appcolors.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';

class RequestBooking extends StatefulWidget {
  final flightId;
  final flightName;
  const RequestBooking(
      {super.key, required this.flightId, required this.flightName});

  @override
  State<RequestBooking> createState() => _RequestBookingState(
      flightId: this.flightId, flightName: this.flightName);
}

class _RequestBookingState extends State<RequestBooking> {
  final flightId;
  final flightName;
  _RequestBookingState({required this.flightId, required this.flightName});

  List adults = [
    "Number of Adults",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  List infants = [
    "Number of Infants",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  String currentSelectedAdults = "Number of Adults";
  String currentSelectedInfants = "Number of Infants";

  var uToken = "";
  final storage = GetStorage();
  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  final TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  bool isPosting = false;

  Future<void> requestBooking() async {
    final requestUrl =
        "https://taxinetghana.xyz/ticketing/request_flight/$flightId/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "flight": flightId,
      "adults": currentSelectedAdults,
      "infants": currentSelectedInfants,
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success 😀", "request sent.An agent will call you shortly",
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text("Request For $flightName"),
            leading: const LeadingButton()),
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
                              // style: const TextStyle(
                              //     color: Colors.black, fontSize: 20),
                              items: adults.map((dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                _onDropDownItemSelectedAdults(newValueSelected);
                              },
                              value: currentSelectedAdults,
                            ),
                          ),
                        ),
                      ),
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
                              // style: const TextStyle(
                              //     color: Colors.black, fontSize: 20),
                              items: infants.map((dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                _onDropDownItemSelectedInfants(
                                    newValueSelected);
                              },
                              value: currentSelectedInfants,
                            ),
                          ),
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
                                    requestBooking();
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

  void _onDropDownItemSelectedAdults(newValueSelected) {
    setState(() {
      currentSelectedAdults = newValueSelected;
    });
  }

  void _onDropDownItemSelectedInfants(newValueSelected) {
    setState(() {
      currentSelectedInfants = newValueSelected;
    });
  }
}
