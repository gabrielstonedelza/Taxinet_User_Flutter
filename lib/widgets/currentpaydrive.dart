import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:taxinet/statics/appcolors.dart';
import 'dart:async';

class CurrentPayDrive extends StatefulWidget {
  final car;
  final driveType;
  final dropOffDate;
  final pickupDate;
  const CurrentPayDrive({super.key,required this.car,required this.driveType,required this.dropOffDate,required this.pickupDate});

  @override
  State<CurrentPayDrive> createState() => _CurrentPayDriveState(car:this.car,driveType:this.driveType,dropOffDate:this.dropOffDate,pickupDate:this.pickupDate);
}

class _CurrentPayDriveState extends State<CurrentPayDrive> {
  final car;
  final driveType;
  final dropOffDate;
  final pickupDate;
  _CurrentPayDriveState({required this.car,required this.driveType,required this.dropOffDate,required this.pickupDate});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: _buildApprovedRentalCard(
            color: defaultYellow,
            dropOffExpiration: dropOffDate,
            carPickUpdate: pickupDate,
            requestedCar: car,
            requestedDriveType: driveType
        ),

      ),
    );
  }

  // Build the credit card widget
  Card _buildApprovedRentalCard(
      { required Color color,
        required String requestedCar,
        required String dropOffExpiration,
        required String carPickUpdate,
        required String requestedDriveType
      }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(requestedCar),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'Drop-off Countdown',
                  value: dropOffExpiration,
                ),
                _buildDetailsBlock2(label: 'Drop-Off Date', value: dropOffExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock(String networkImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/logo3.png",
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 120,),
        Expanded(
          child: Image.network(
            networkImage,
            height: 100,
            width: 120,
          ),
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        CountDownText(
          due: DateTime.parse(value),
          finishedText: "Done",
          showLabel: true,
          longDateName: false,
          daysTextLong: " DAYS ",
          hoursTextLong: " HOURS ",
          minutesTextLong: " MINUTES ",
          secondsTextLong: " SECONDS ",
          style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
        )
      ],
    );
  }
  Column _buildDetailsBlock2({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
