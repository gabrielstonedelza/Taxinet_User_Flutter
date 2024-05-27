import 'package:flutter/material.dart';
import 'package:taxinet/statics/appcolors.dart';

class CreditCardsPage extends StatefulWidget {
  final cardHolder;
  final walletAmount;
  const CreditCardsPage({super.key,required this.cardHolder,required this.walletAmount});

  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState(cardHolder:this.cardHolder,walletAmount:this.walletAmount);
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  final cardHolder;
  final walletAmount;
  _CreditCardsPageState({required this.cardHolder,required this.walletAmount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: _buildCreditCard(
            color: defaultYellow,
            cardExpiration: "08/2050",
            cardHolder: cardHolder,
            userWalletAmount: walletAmount.toString()),
      ),
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      { required Color color,
      required String userWalletAmount,
      required String cardHolder,
      required String cardExpiration }) {
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
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "₵$userWalletAmount",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'Wallet User',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          "assets/images/logo3.png",
          width: 50,
          height: 50,
        ),
        Image.asset(
          "assets/images/mastercard.png",
          height: 50,
          width: 50,
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
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
