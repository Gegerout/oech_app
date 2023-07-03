import 'package:flutter/material.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/home/presentation/widgets/payment_card_widget.dart';

import '../../../core/theme/colors.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final List data = [
    ["Pay with wallet", "complete the payment using your e wallet"],
    ["Credit / debit card", "add new card"],
    ["**** **** 3323", "remove card"]
  ];

  int currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/arrow-square-right.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add payment method",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey2Color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            const SizedBox(height: 67),
            SizedBox(
              height: 100.0 * data.length,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: paymentCardWidget(data[index][0], data[index][1],
                            currentIndex == index)),
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 105),
              child: SizedBox(
                width: double.infinity,
                  height: 46,
                  child:
                      primaryButton("Proceed to pay", () {}, FontWeight.w700, 16)),
            ),
          ],
        ),
      ),
    );
  }
}
