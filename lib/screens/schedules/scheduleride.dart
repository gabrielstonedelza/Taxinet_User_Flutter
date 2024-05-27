import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:taxinet/screens/showroom/showroom.dart';

import '../../controllers/map/mapcontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';
import 'locatedropoffonmap.dart';
import 'locatepickuponmap.dart';

class ScheduleRide extends StatefulWidget {
  const ScheduleRide({Key? key}) : super(key: key);

  @override
  State<ScheduleRide> createState() => _ScheduleRideState();
}

class _ScheduleRideState extends State<ScheduleRide> {
  List scheduleOptions = [
    "Select Schedule Duration",
    "One Time",
    "Daily",
    "Weekly",
    "Until Cancelled"
  ];
  List scheduleTypes = [
    "Select Schedule Type",
    "School Pick up And Drop Off",
    "Office Pick up And Drop Off",
    "Airport Pick up And Drop Off",
    "Hotel Pick up And Drop Off",
  ];

  String _currentSelectedScheduleType = "Select Schedule Type";
  String _currentSelectedScheduleDuration = "Select Schedule Duration";

  late final TextEditingController _scheduleTitleController =
      TextEditingController();

  late final TextEditingController _scheduleDescriptionController =
      TextEditingController();

  late final TextEditingController _pickUpLocationController =
      TextEditingController();
  late final TextEditingController _myLocationUpLocationController;

  late final TextEditingController _dropOffLocationController =
      TextEditingController();

  late final TextEditingController _pickUpTimeController =
      TextEditingController();

  late final TextEditingController _startDateController =
      TextEditingController();
  late final TextEditingController _daysController = TextEditingController();

  final FocusNode _daysFocusNode = FocusNode();

  final FocusNode _pickUpLocationFocusNode = FocusNode();

  final FocusNode _dropOffLocationFocusNode = FocusNode();

  var uToken = "";
  final storage = GetStorage();
  var username = "";

  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  bool isPosting = false;
  final MapController _mapController = Get.find();
  bool isDays = false;
  String promoter = "";
  double initialBonus = 0.0;
  String walletId = "";
  bool isLoading = true;

  bool isPickingFromMap = false;

  Future<void> scheduleRide() async {
    const requestUrl = "https://taxinetghana.xyz/schedule/request_ride/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "schedule_type": _currentSelectedScheduleType,
      "schedule_duration": _currentSelectedScheduleDuration,
      "pickup_location": _pickUpLocationController.text,
      "drop_off_location": _dropOffLocationController.text,
      "pick_up_time": _pickUpTimeController.text,
      "start_date": _startDateController.text,
      "drop_off_lat": _mapController.userDropOffLatitude.toString(),
      "drop_off_lng": _mapController.userDropOffLng.toString(),
      "pickup_lng": isPickingFromMap
          ? _mapController.userPickUpLng.toString()
          : _mapController.userLongitude.toString(),
      "pickup_lat": isPickingFromMap
          ? _mapController.userPickUpLatitude.toString()
          : _mapController.userLatitude.toString(),
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success 😀", "request sent.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryYellow,
          colorText: defaultTextColor1);
      double bonusAmount = 0.05;
      double deAmount = bonusAmount + initialBonus;
      setState(() {
        _scheduleTitleController.text = "";
        _currentSelectedScheduleType = "Select Schedule Type";
        _scheduleDescriptionController.text = "";
        _pickUpLocationController.text = "";
        _dropOffLocationController.text = "";
        _pickUpTimeController.text = "";
        _startDateController.text = "";
        _mapController.pickUpLocation = "";
        _mapController.dropOffLocation = "";
      });
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
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    _myLocationUpLocationController =
        TextEditingController(text: _mapController.myLocationName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Ride",
            style: TextStyle(color: defaultTextColor2)),
        centerTitle: true,
        leading: const LeadingButton(),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          SlideInUp(
            animate: true,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.green),
                        Text(_mapController.myLocationName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultBlack)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            items: scheduleTypes.map((dropDownStringItem) {
                              return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              _onDropDownItemSelectedScheduleType(
                                  newValueSelected);
                            },
                            value: _currentSelectedScheduleType,
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
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            items: scheduleOptions.map((dropDownStringItem) {
                              return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              _onDropDownItemSelectedScheduleDuration(
                                  newValueSelected);
                            },
                            value: _currentSelectedScheduleDuration,
                          ),
                        ),
                      ),
                    ),
                    const Text("Want to pick a new location?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<MapController>(builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 10),
                            child: TextFormField(
                              onTap: () {
                                Get.to(
                                    () => LocatePickUpOnMap(pickUp: "PickUp"));
                              },
                              readOnly: true,
                              autocorrect: true,
                              controller: _pickUpLocationController
                                ..text = controller.pickUpLocation,
                              focusNode: _pickUpLocationFocusNode,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.location_on,
                                    color: Colors.green),
                                border: InputBorder.none,
                                hintText: "Pick Up Location",
                                hintStyle: TextStyle(color: defaultTextColor2),
                              ),
                              cursorColor: defaultTextColor2,
                              style: const TextStyle(color: defaultTextColor2),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Pick Up Location";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<MapController>(builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 10),
                            child: TextFormField(
                              onTap: () {
                                Get.to(() =>
                                    LocateDropOffOnMap(drop_off: "DropOff"));
                              },
                              readOnly: true,
                              autocorrect: true,
                              controller: _dropOffLocationController
                                ..text = controller.dropOffLocation,
                              focusNode: _dropOffLocationFocusNode,
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.location_on, color: Colors.red),
                                border: InputBorder.none,
                                hintText: "Drop Off Location",
                                hintStyle: TextStyle(color: defaultTextColor2),
                              ),
                              cursorColor: defaultTextColor2,
                              style: const TextStyle(color: defaultTextColor2),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Drop Off Location";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _startDateController,
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
                                    _startDateController.text =
                                        _dateTime.toString().split("00").first;
                                  });
                                });
                              },
                            ),
                            labelText: "click on icon to pick date",
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
                                  scheduleRide();
                                } else {
                                  Get.snackbar("Error", "Something went wrong",
                                      colorText: defaultTextColor2,
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
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDropDownItemSelectedScheduleType(newValueSelected) {
    setState(() {
      _currentSelectedScheduleType = newValueSelected;
    });
  }

  void _onDropDownItemSelectedScheduleDuration(newValueSelected) {
    setState(() {
      _currentSelectedScheduleDuration = newValueSelected;
    });
  }
}
