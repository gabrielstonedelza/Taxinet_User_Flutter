import 'package:flutter/material.dart';

import '../../widgets/backbutton.dart';

class AboutDrives extends StatelessWidget {
  const AboutDrives({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About Taxinet Drives"),
          leading: const LeadingButton(),
        ),
        body: ListView(
          children: [],
        ));
  }
}
