import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import '../../controllers/profile/profilecontroller.dart';
import '../../controllers/wallet/walletcontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/backbutton.dart';
import '../../widgets/credit_cards_page.dart';

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
      appBar: AppBar(
        title: const Text("Wallet and Updates"),
        leading: const LeadingButton(),
      ),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [

          SizedBox(
            height: 230,
            child: GetBuilder<WalletController>(
                builder: (controller) {
                  return ListView.builder(
                      itemCount:
                      controller.myWalletDetails != null
                          ? controller.myWalletDetails.length
                          : 0,
                      itemBuilder: (context, index) {
                        item = controller.myWalletDetails[index];
                        return CreditCardsPage(cardHolder: item['get_full_name'], walletAmount: item['amount']);
                      });
                }),
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
                    return Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8),
                      child: Card(
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
