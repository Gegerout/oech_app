import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/presentation/states/send_package_state.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons.dart';
import 'home_page.dart';

class DeliverySuccessPage extends ConsumerStatefulWidget {
  const DeliverySuccessPage(this.track, {Key? key}) : super(key: key);

  final String track;

  @override
  ConsumerState<DeliverySuccessPage> createState() => _DeliverySuccessPageState();
}

class _DeliverySuccessPageState extends ConsumerState<DeliverySuccessPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  TextEditingController controller = TextEditingController();

  late Timer _timer;
  int _start = 4;
  bool isComplete = false;
  int currentIndex = -1;
  double dx = 100, dy = 100;

  List images = [
    "assets/images/check_1.png",
    "assets/images/check_2.png",
    "assets/images/check_3.png",
    "assets/images/check_4.png",
    "assets/images/check_5.png"
  ];

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isComplete = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 99),
                Center(
                  child: isComplete
                      ? Stack(
                          children: [
                            Image.asset(
                              images[0],
                              width: 129,
                              height: 129,
                              fit: BoxFit.fill,
                            ),
                            FadeInImage(
                              fadeInDuration: const Duration(seconds: 1),
                              placeholder: AssetImage(images[1]),
                              image: AssetImage(images[1]),
                              width: 129,
                              height: 129,
                              fit: BoxFit.fill,
                            ),
                            FadeInImage(
                              fadeInDuration: const Duration(seconds: 1),
                              placeholder: AssetImage(images[1]),
                              image: AssetImage(images[2]),
                              width: 129,
                              height: 129,
                              fit: BoxFit.fill,
                            ),
                            FadeInImage(
                              fadeInDuration: const Duration(seconds: 1),
                              placeholder: AssetImage(images[1]),
                              image: AssetImage(images[3]),
                              width: 129,
                              height: 129,
                              fit: BoxFit.fill,
                            ),
                            FadeInImage(
                              fadeInDuration: const Duration(seconds: 1),
                              placeholder: AssetImage(images[1]),
                              image: AssetImage(images[4]),
                              width: 129,
                              height: 129,
                              fit: BoxFit.fill,
                            )
                          ],
                        )
                      : AnimatedBuilder(
                          animation: _controller,
                          builder: (_, child) {
                            return Transform.rotate(
                              angle: -_controller.value * 2 * math.pi,
                              child: child,
                            );
                          },
                          child: Image.asset(
                            "assets/images/circ_1.png",
                            width: 119,
                            height: 119,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                SizedBox(height: isComplete ? 75 : 130),
                isComplete
                    ? Column(
                        children: [
                          Text(
                            "Delivery Successful",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Your Item has been delivered successfully",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.textColor),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: isComplete ? 67 : 89),
                Text(
                  "Rate Rider",
                  style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 16),
                StreamBuilder<GyroscopeEvent>(
                  stream: SensorsPlatform.instance.gyroscopeEvents,
                    builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    dx = dx + snapshot.data!.x * 10;
                    dy = dy + snapshot.data!.y * 10;

                    if(dy <= 90 && currentIndex >= 0) {
                      currentIndex--;
                    }

                    if(dy >= 130 && currentIndex <= 4) {
                      currentIndex++;
                    }
                    
                    return SizedBox(
                      height: 48,
                      width: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            icon: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              child: currentIndex >= index
                                  ? Image.asset(
                                "assets/images/star_icon_active.png",
                                width: 17,
                                height: 16,
                                fit: BoxFit.fill,
                              )
                                  : Image.asset(
                                "assets/images/star_icon.png",
                                width: 17,
                                height: 16,
                                fit: BoxFit.fill,
                              ),
                            )
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                }),
                const SizedBox(height: 37),
                Material(
                  elevation: 4,
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(fontSize: 12, color: AppColors.textColor),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.feedback_rounded, color: AppColors.primaryColor, size: 18,),
                        contentPadding: const EdgeInsets.only(left: 12),
                        hintText: "Add feedback",
                        hintStyle:
                            TextStyle(fontSize: 12, color: AppColors.grey2Color),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 76),
                SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: primaryButton("Done", () {
                      ref.read(sendPackageProvider.notifier).sendRate([
                        currentIndex,
                        controller.text
                      ], widget.track);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage(0)),
                          (route) => false);
                    }, FontWeight.w700, 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
