import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taxinet/screens/ticketing/searchandrequestflight.dart';
import 'package:taxinet/widgets/backbutton.dart';
import 'package:get/get.dart';
import '../../statics/appcolors.dart';

class ShowCalender extends StatefulWidget {
  const ShowCalender({super.key});

  @override
  State<ShowCalender> createState() => _ShowCalenderState();
}

class _ShowCalenderState extends State<ShowCalender> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  List airlines = ["Select Airline", "PassionAir", "Africa World Airlines"];
  String _currentSeletedAirline = "Select Airline";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Date"), leading: const LeadingButton()),
      body: SlideInUp(
        animate: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: TableCalendar(
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: today,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  onDaySelected: _onDaySelected,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Text("Selected date :  ${today.toString().split(" ").first}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(
                height: 20,
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
                      // style: const TextStyle(
                      //     color: Colors.black, fontSize: 20),
                      items: airlines.map((dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        _onDropDownItemSelectedAirline(newValueSelected);
                      },
                      value: _currentSeletedAirline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryYellow),
                height: size.height * 0.06,
                width: size.width * 0.6,
                child: RawMaterialButton(
                  onPressed: () {
                    if (_currentSeletedAirline == "Select Airline") {
                      Get.snackbar("Airline Error", "Please select airline",
                          colorText: defaultTextColor1,
                          duration: const Duration(seconds: 5),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red);
                      return;
                    } else {
                      Get.to(() => AllAvailableFlightsForPassionAir(
                            departDate: today.toString().split(" ").first,
                            airline: _currentSeletedAirline,
                          ));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 8,
                  fillColor: primaryYellow,
                  child: const Text(
                    "Search",
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
    );
  }

  void _onDropDownItemSelectedAirline(newValueSelected) {
    setState(() {
      _currentSeletedAirline = newValueSelected;
    });
  }
}
