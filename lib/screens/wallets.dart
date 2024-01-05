import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import '../controllers/profile/profilecontroller.dart';
import '../controllers/wallet/walletcontroller.dart';
import '../statics/appcolors.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String username = "";
  final storage = GetStorage();
  final ProfileController profileController = Get.find();
  var items;
  var item;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            color: defaultYellow,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8),
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Taxinet Card",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Image.asset(
                          "assets/images/logo3.png",
                          width: 70,
                          height: 100,
                        )
                      ],
                    ),
                    GetBuilder<WalletController>(builder: (controller) {
                      return SizedBox(
                          height: 25,
                          child: ListView.builder(
                              itemCount: controller.myWalletDetails != null
                                  ? controller.myWalletDetails.length
                                  : 0,
                              itemBuilder: (context, index) {
                                item = controller.myWalletDetails[index];
                                return Center(
                                  child: Text("₵${item['amount']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                );
                              }));
                    }),
                    const SizedBox(height: 30),
                    GetBuilder<ProfileController>(builder: (controller) {
                      return Center(
                        child: Text(controller.fullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 500,
            child: GetBuilder<WalletController>(builder: (controller) {
              return ListView.builder(
                  itemCount: controller.allUpdatedWalletDetails != null
                      ? controller.allUpdatedWalletDetails.length
                      : 0,
                  itemBuilder: (context, index) {
                    items = controller.allUpdatedWalletDetails[index];
                    return Card(
                      color: defaultYellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("₵${items['amount']}"),
                        ),
                        subtitle: Row(
                          children: [
                            Text(items['date_updated']
                                .toString()
                                .split("T")
                                .first),
                            const Text(" | "),
                            Text(items['date_updated']
                                .toString()
                                .split("T")
                                .last
                                .split(".")
                                .first)
                          ],
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    ));
  }
}
