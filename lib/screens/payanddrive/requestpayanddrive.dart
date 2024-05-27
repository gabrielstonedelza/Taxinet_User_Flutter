import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:taxinet/controllers/profile/profilecontroller.dart';
import 'package:taxinet/screens/showroom/showroom.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import 'package:http/http.dart' as http;
import '../homepage.dart';

class RequestPayAndDrive extends StatefulWidget {
  final id;
  final driveType;
  const RequestPayAndDrive(
      {super.key,
      required this.id,
      required this.driveType,
      });

  @override
  State<RequestPayAndDrive> createState() => _RequestPayAndDriveState(
      id: this.id,
    driveType: this.driveType,
  );
}

class _RequestPayAndDriveState extends State<RequestPayAndDrive> {
  final id;
  final driveType;

  _RequestPayAndDriveState(
      {required this.id,required this.driveType});

  var uToken = "";
  final storage = GetStorage();
  final ProfileController profileController = Get.find();

  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  late final TextEditingController pickUpDateController;
  late final TextEditingController dropOffDateController;
  late final TextEditingController referralController;
  late final TextEditingController _pickUpTimeController;
  late final TextEditingController _pickUpLocationController;
  bool isPosting = false;

  Future<void> requestPayAndDrive() async {
    const requestUrl =
        "https://taxinetghana.xyz/pay_drive/request_pay_and_drive/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "user": profileController.userId,
      "car": id,
      "drive_type": driveType,
      "pick_up_date": pickUpDateController.text,
      "drop_off_date": dropOffDateController.text,
      "pick_up_time": _pickUpTimeController.text,
      "pick_up_location": _pickUpLocationController.text,
      "referral": referralController.text,
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success 😀", "Request sent,please stand by an agent will call you soon.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow,
          colorText: defaultTextColor1);

      Get.offAll(() => const Showroom());
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
    referralController = TextEditingController();
    _pickUpTimeController = TextEditingController();
    _pickUpLocationController = TextEditingController();
  }

  @override
  void dispose() {
    pickUpDateController.dispose();
    dropOffDateController.dispose();
    referralController.dispose();
    _pickUpTimeController.dispose();
    _pickUpLocationController.dispose();
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
                          controller: _pickUpTimeController,
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
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    setState(() {
                                      _timeOfDay = value!;
                                      _pickUpTimeController.text =
                                          _timeOfDay.format(context).toString();
                                    });
                                  });
                                },
                              ),
                              labelText: "Click on icon to pick up time",
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
                              return "Please pick a start date";
                            }
                          },
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
                                  Icons.calendar_month_outlined,
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
                              labelText: "Tap on icon for Pick up date",
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
                                  Icons.calendar_month_outlined,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: _pickUpLocationController,
                          cursorColor: defaultBlack,
                          cursorRadius: const Radius.elliptical(10, 10),
                          cursorWidth: 10,
                          style: const TextStyle(color: defaultTextColor2),
                          decoration: InputDecoration(
                              labelText: "Enter Pick up location.",
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          controller: referralController,
                          cursorColor: defaultBlack,
                          cursorRadius: const Radius.elliptical(10, 10),
                          cursorWidth: 10,
                          style: const TextStyle(color: defaultTextColor2),
                          decoration: InputDecoration(
                              labelText: "Enter Referral Number",
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
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  setState(() {
                                    isPosting = true;
                                  });
                                  _startPosting();
                                  if (_formKey.currentState!.validate()) {
                                    requestPayAndDrive();
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
                                fillColor: defaultYellow,
                                child: const Text(
                                  "Request",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: defaultTextColor2),
                                ),
                              ),
                            ),
                      const SizedBox(height: 30,),
                      const Text("NB:  Enter Taxinet if you have no referral",style: TextStyle(fontWeight: FontWeight.w900),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
