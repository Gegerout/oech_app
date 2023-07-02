import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/presentation/states/wallet_state.dart';

import '../../../core/theme/colors.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(walletProvider).when(
        data: (value) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 63,
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                "Wallet",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey2Color),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://feyqfihsyhchwsjseqsg.supabase.co/storage/v1/object/public/images/profile_image.png?t=2023-06-29T11%3A00%3A58.645Z",
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.textColor),
                          ),
                          Row(
                            children: [
                              Text(
                                "Current balance:",
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.textColor),
                              ),
                              Text(
                                ref.watch(walletDataProvider).isShowed
                                    ? value.balance
                                    : "******",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ref.read(walletDataProvider.notifier).changeShowed();
                        },
                        child: ref.watch(walletDataProvider).isShowed
                            ? Image.asset(
                                "assets/images/eye-slash.png",
                                scale: 3.5,
                              )
                            : Icon(
                                Icons.visibility,
                                color: AppColors.text3Color,
                                size: 20,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  Container(
                    height: 116,
                    decoration: BoxDecoration(
                        color: AppColors.grey1Color,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Top Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Image.asset(
                                    "assets/images/wallet_bank.png",
                                    width: 21,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Bank",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Image.asset(
                                    "assets/images/wallet_transfer.png",
                                    width: 21,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Transfer",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Image.asset(
                                    "assets/images/wallet_card.png",
                                    width: 21,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Card",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
                  Text(
                    "Transaction History",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.textColor),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.transactions?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SizedBox(
                              height: 44,
                              child: Material(
                                elevation: 1,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(
                                            value.transactions?[index][0],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColor),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            value.transactions?[index][1],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.grey2Color),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        value.transactions?[index][2],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: value.transactions?[index]
                                                        [0] ==
                                                    "Delivery fee"
                                                ? AppColors.errorColor
                                                : AppColors.successColor),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
        error: (error, stacktrace) {
          return Scaffold(
            body: Center(
              child: Text(error.toString()),
            ),
          );
        },
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
