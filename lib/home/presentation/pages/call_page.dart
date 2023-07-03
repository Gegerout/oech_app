import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/home/presentation/states/call_state.dart';

class CallPage extends ConsumerWidget {
  const CallPage({Key? key, required this.regNum}) : super(key: key);

  final String regNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(callProvider(regNum)).when(
          data: (value) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 85),
                    CachedNetworkImage(
                      imageUrl: value.avatar,
                      width: 84,
                      height: 84,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 9),
                    Text(
                      value.name,
                      style: TextStyle(
                          fontSize: 18.6,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      value.phone,
                      style: TextStyle(
                          fontSize: 18.6,
                          fontWeight: FontWeight.w700,
                          color: AppColors.grey2Color),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      "calling...",
                      style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 113),
                    Container(
                      width: double.infinity,
                      height: 332,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.1),
                        color: AppColors.grey6Color
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 49),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/call_plus_icon.png",
                                width: 30,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              Image.asset(
                                "assets/images/call_pause_icon.png",
                                width: 12,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              Image.asset(
                                "assets/images/call_video_icon.png",
                                width: 33,
                                height: 24,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/call_speaker_icon.png",
                                width: 32,
                                height: 28,
                                fit: BoxFit.fill,
                              ),
                              Image.asset(
                                "assets/images/call_micro_icon.png",
                                width: 31,
                                height: 31.4,
                                fit: BoxFit.fill,
                              ),
                              Image.asset(
                                "assets/images/call_pad_icon.png",
                                width: 35.5,
                                height: 35.5,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          const SizedBox(height: 59),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 71,
                              height: 71,
                              child: CircleAvatar(
                                backgroundColor: AppColors.errorColor,
                                child: Image.asset(
                                  "assets/images/call_icon.png",
                                  width: 40,
                                  height: 38,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
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
              )),
    );
  }
}
