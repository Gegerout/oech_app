import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/home/presentation/pages/call_page.dart';
import 'package:oech_app/home/presentation/pages/rider_chat_page.dart';
import 'package:oech_app/home/presentation/states/riders_state.dart';

import '../../../core/theme/colors.dart';

class RiderProfilePage extends ConsumerStatefulWidget {
  const RiderProfilePage(this.regNum, {Key? key}) : super(key: key);

  final String regNum;

  @override
  ConsumerState<RiderProfilePage> createState() => _RiderProfilePageState();
}

class _RiderProfilePageState extends ConsumerState<RiderProfilePage> {
  var markers = <Marker>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.refresh(getRiderProfileProvider(widget.regNum)).value;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 63,
          backgroundColor: Colors.white,
          elevation: 0,
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
            "Rider profile",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.grey2Color),
          ),
        ),
        body: ref.watch(getRiderProfileProvider(widget.regNum)).when(
            data: (value) {
              markers = [
                Marker(
                  point: LatLng(value.$1.latitude, value.$1.longitude),
                  builder: (context) => Image.asset(
                    "assets/images/pin_icon.png",
                  ),
                ),
                Marker(
                  point: LatLng(
                      value.$1.latitude + 0.015, value.$1.longitude - 0.018),
                  builder: (context) => Image.asset(
                    "assets/images/pin_icon.png",
                  ),
                ),
                Marker(
                  point: LatLng(
                      value.$1.latitude + 0.02, value.$1.longitude + 0.02),
                  builder: (context) => Image.asset(
                    "assets/images/pin_icon.png",
                  ),
                )
              ];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: 241,
                            child: FlutterMap(
                              options: MapOptions(
                                  center: LatLng(value.$1.latitude + 0.006,
                                      value.$1.longitude),
                                  zoom: 12),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      "https://a.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}@2x.png",
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: markers,
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 196),
                          child: Center(
                              child: CachedNetworkImage(
                            imageUrl: value.$2.avatar,
                            width: 84,
                            height: 84,
                            fit: BoxFit.fill,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 9),
                    Center(
                      child: Text(
                        value.$2.name,
                        style: TextStyle(
                            fontSize: 18.6,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 9,
                              width: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, curIndex) {
                                  return int.parse(value.$2.rate) > curIndex
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              right: curIndex == 4 ? 0 : 8.26),
                                          child: Image.asset(
                                            "assets/images/star_icon_active.png",
                                            width: 9,
                                            height: 9,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              right: curIndex == 4 ? 0 : 8.26),
                                          child: Image.asset(
                                            "assets/images/star_icon.png",
                                            width: 9,
                                            height: 9,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Car Model",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.secondaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(value.$2.car,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.grey2Color))
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Registration Number",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.secondaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(value.$2.regNum,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.grey2Color))
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.secondaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(value.$2.gender,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.grey2Color))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 28),
                          Text(
                            "Customer Reviews",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textColor),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: ref.watch(ridersProvider).isAll
                                ? value.$2.feedbacks!.length * 88.0
                                : value.$2.feedbacks != null
                                    ? 2 * 88.0
                                    : 0,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ref.watch(ridersProvider).isAll
                                  ? value.$2.feedbacks?.length
                                  : value.$2.feedbacks != null
                                      ? 2
                                      : 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.8),
                                  child: Material(
                                      elevation: 2,
                                      color: Colors.white,
                                      child: SizedBox(
                                        height: 84,
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  value.$2.feedbacks?[index][0],
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fill,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.$2.feedbacks?[index][2],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.textColor),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  value.$2.feedbacks?[index][3],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.textColor),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 9,
                                              width: 80,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: 5,
                                                itemBuilder:
                                                    (context, curIndex) {
                                                  return int.parse(value.$2
                                                                  .feedbacks?[
                                                              index][1]) >
                                                          curIndex
                                                      ? Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  curIndex == 4
                                                                      ? 0
                                                                      : 8.26),
                                                          child: Image.asset(
                                                            "assets/images/star_icon_active.png",
                                                            width: 9,
                                                            height: 9,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  curIndex == 4
                                                                      ? 0
                                                                      : 8.26),
                                                          child: Image.asset(
                                                            "assets/images/star_icon.png",
                                                            width: 9,
                                                            height: 9,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                          ref.watch(ridersProvider).isAll
                              ? Container()
                              : Row(
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          ref
                                              .read(ridersProvider.notifier)
                                              .changeView();
                                        },
                                        child: Text(
                                          "View More",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.primaryColor),
                                        ))
                                  ],
                                ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 164,
                                  height: 48,
                                  child: primaryButton("Send message", () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RiderChatPage(
                                                  regNum: value.$2.regNum,
                                                )));
                                  }, FontWeight.w700, 16)),
                              SizedBox(
                                  width: 164,
                                  height: 48,
                                  child: secondaryButton("Call rider", () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CallPage(
                                                regNum: value.$2.regNum)));
                                  }, FontWeight.w700, 16))
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    )
                  ],
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
                )));
  }
}
