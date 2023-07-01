import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/home/presentation/pages/home_page.dart';

class SuccessfulTransactionPage extends StatefulWidget {
  const SuccessfulTransactionPage({Key? key, required this.track})
      : super(key: key);

  final String track;

  @override
  State<SuccessfulTransactionPage> createState() =>
      _SuccessfulTransactionPageState();
}

class _SuccessfulTransactionPageState extends State<SuccessfulTransactionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  late Timer _timer;
  int _start = 4;
  bool isComplete = false;

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
                  ? Text(
                      "Transaction Successful",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor),
                    )
                  : Container(),
              SizedBox(
                height: isComplete ? 8 : 0,
              ),
              Text(
                "Your rider is on the way to your destination",
                style: TextStyle(fontSize: 14, color: AppColors.textColor),
              ),
              const SizedBox(height: 8),
              RichText(
                  text: TextSpan(
                      text: "Tracking Number ",
                      style:
                          TextStyle(fontSize: 14, color: AppColors.textColor),
                      children: [
                    TextSpan(
                        text: widget.track,
                        style: TextStyle(
                            fontSize: 14, color: AppColors.primaryColor))
                  ])),
              const SizedBox(height: 141),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: primaryButton(
                      "Track my item", () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(2)),
                            (route) => false);
                  }, FontWeight.w700, 16)),
              const SizedBox(height: 8),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: secondaryButton("Go back to homepage", () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(0)),
                        (route) => false);
                  }, FontWeight.w700, 16))
            ],
          ),
        ),
      ),
    );
  }
}
