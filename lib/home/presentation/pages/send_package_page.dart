import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/home/presentation/pages/succesful_transaction_page.dart';
import 'package:oech_app/home/presentation/states/send_package_state.dart';
import 'package:oech_app/home/presentation/widgets/destination_card_widget.dart';
import 'package:oech_app/home/presentation/widgets/package_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/colors.dart';

class SendPackagePage extends ConsumerStatefulWidget {
  SendPackagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<SendPackagePage> createState() => _SendPackagePageState();
}

class _SendPackagePageState extends ConsumerState<SendPackagePage> {
  TextEditingController address1 = TextEditingController();

  TextEditingController state1 = TextEditingController();

  TextEditingController phone1 = TextEditingController();

  TextEditingController address2 = TextEditingController();

  TextEditingController state2 = TextEditingController();

  TextEditingController phone2 = TextEditingController();

  TextEditingController items = TextEditingController();

  TextEditingController weight = TextEditingController();

  TextEditingController worth = TextEditingController();

  late String track;

  @override
  void initState() {
    super.initState();
    const chars = "1234567890";
    String creation() =>
        List.generate(4, (index) => chars[Random().nextInt(chars.length)])
            .join();
    track =
        "R-${creation()}-${creation()}-${creation()}-${creation()}";
  }

  @override
  void dispose() {
    ref.read(sendPackageProvider).count = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = ref.watch(sendPackageProvider).currentIndex;
    List data = ref.watch(sendPackageProvider).data;
    ref.refresh(addressProvider).value;
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              ref.read(sendPackageProvider).count = 1;
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
          "Send a package",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey2Color),
        ),
      ),
      body: ref.watch(addressProvider).when(
              data: (value) {
                address1.text = "${value.addressDetails.road} ${value.addressDetails.city}";
                state1.text = "${value.addressDetails.state}, ${value.addressDetails.country}";

                return Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 43),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/origin_icon.png",
                              width: 16,
                              height: 16,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Origin Details",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        packageTextField("Address", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text, controller: address1),
                        const SizedBox(height: 5),
                        packageTextField("State,Country", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text, controller: state1),
                        const SizedBox(height: 5),
                        packageTextField("Phone number", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.phone, controller: phone1),
                        const SizedBox(height: 5),
                        packageTextField("Others", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 210.0 * ref.watch(sendPackageProvider).count,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ref.watch(sendPackageProvider).count,
                            itemBuilder: (context, index) {
                              return destinationCardWidget(address2, state2, phone2,
                                      (value) {
                                    ref.read(sendPackageProvider.notifier).checkCreds(
                                        address1.text,
                                        state1.text,
                                        phone1.text,
                                        address2.text,
                                        state2.text,
                                        phone2.text,
                                        items.text,
                                        weight.text,
                                        worth.text);
                                  }, index);
                            },
                          ),
                        ),
                        const SizedBox(height: 17),
                        InkWell(
                          onTap: () {
                            ref.read(sendPackageProvider.notifier).addCount();
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/add-square.png",
                                width: 14,
                                height: 14,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Add destination",
                                style:
                                TextStyle(fontSize: 12, color: AppColors.grey2Color),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          "Package Details",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(height: 8),
                        packageTextField("package items", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text, controller: items),
                        const SizedBox(height: 8),
                        packageTextField("Weight of item(kg)", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text, controller: weight),
                        const SizedBox(height: 8),
                        packageTextField("Worth of Items", (value) {
                          ref.read(sendPackageProvider.notifier).checkCreds(
                              address1.text,
                              state1.text,
                              phone1.text,
                              address2.text,
                              state2.text,
                              phone2.text,
                              items.text,
                              weight.text,
                              worth.text);
                        }, TextInputType.text, controller: worth),
                        const SizedBox(height: 39),
                        Text("Select delivery type",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 75,
                          child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: index == 0 ? 24 : 0),
                                child: InkWell(
                                  onTap: index == 0
                                      ? () {
                                    ref
                                        .read(sendPackageProvider.notifier)
                                        .changeIndex(index);
                                    if (ref.watch(sendPackageProvider).isValid) {
                                      ref
                                          .read(sendPackageProvider.notifier)
                                          .createOrder(
                                          address1.text,
                                          state1.text,
                                          phone1.text,
                                          address2.text,
                                          state2.text,
                                          phone2.text,
                                          items.text,
                                          weight.text,
                                          worth.text,
                                          supabase.auth.currentUser!.email!, track);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmOrderPage(track)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Wrong input"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Ok"))
                                            ],
                                          ));
                                    }
                                  }
                                      : null,
                                  child: Material(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: 159,
                                      height: 75,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: currentIndex == index
                                              ? AppColors.primaryColor
                                              : Colors.white),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            currentIndex == index
                                                ? data[index][1]
                                                : data[index][0],
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            data[index][2],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: currentIndex == index
                                                    ? Colors.white
                                                    : AppColors.grey2Color),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stacktrace) {
                return AlertDialog(
                  title: Text(error.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                );
              },
              loading: () => const Center(
                      child: CircularProgressIndicator(),
              ))
    );
  }
}

class ConfirmOrderPage extends ConsumerWidget {
  const ConfirmOrderPage(this.track, {Key? key}) : super(key: key);

  final String track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.refresh(orderProvider(track)).value;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Send a package",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey2Color),
        ),
      ),
      body: ref.watch(orderProvider(track)).when(
          data: (value) {
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "Package Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Origin details",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${value.origins[0]}, ${value.origins[1].toString().split(",")[0]}",
                    style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.origins[2],
                    style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Destination details",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${value.destinations[0]}, ${value.destinations[1].toString().split(",")[0]}",
                    style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.destinations[2],
                    style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Other details",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Package items",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Weight of items",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Tracking number",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            value.packages[0],
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            value.packages[1],
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            value.track,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 37),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(thickness: 1, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Charges",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Instant delivery",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Tax and Service Charges",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.grey2Color),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "N2,500.00",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "N300.00",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "N200.00",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.secondaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(thickness: 1, color: AppColors.grey2Color),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Package total",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.grey2Color),
                      ),
                      const Spacer(),
                      Text(
                        "N3000.00",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 168,
                          height: 48,
                          child: secondaryButtonSmall("Edit package", () {
                            ref.refresh(orderProvider(track)).value;
                            Navigator.pop(context);
                          }, FontWeight.w700, 16)),
                      const SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                          width: 168,
                          height: 48,
                          child: primaryButtonSmall("Make payment", () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SuccessfulTransactionPage(track: value.track,)),
                                (route) => false);
                          }, FontWeight.w700, 16))
                    ],
                  )
                ],
              ),
            );
          },
          error: (error, stacktrace) {
            return AlertDialog(
                title: Text(error.toString()),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
                ],
            );
          },
          loading: () => const Center(
                  child: CircularProgressIndicator(),
              )),
    );
  }
}
