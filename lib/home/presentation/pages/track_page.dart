import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/home/presentation/pages/send_package_page.dart';
import 'package:oech_app/home/presentation/states/track_state.dart';

import '../states/home_state.dart';

class TrackPage extends ConsumerStatefulWidget {
  const TrackPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends ConsumerState<TrackPage> {
  var markers = <Marker>[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.refresh(positionProvider(ref.watch(homeProvider).orders[0])).value;
    return Scaffold(
        body:
            ref.watch(positionProvider(ref.watch(homeProvider).orders[0])).when(
                data: (value) {
                  markers = [
                    Marker(
                      point: LatLng(value.$1.latitude, value.$1.longitude),
                      builder: (context) => Image.asset(
                        "assets/images/pin_icon.png",
                      ),
                    ),
                    Marker(
                      point: LatLng(value.$1.latitude - 0.0007, value.$1.longitude + 0.003),
                      builder: (context) => Image.asset(
                        "assets/images/pin_icon.png",
                      ),
                    ),
                    Marker(
                      point: LatLng(value.$1.latitude + 0.01, value.$1.longitude + 0.01),
                      builder: (context) => Image.asset(
                        "assets/images/pin_icon.png",
                      ),
                    )
                  ];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 341,
                          child: FlutterMap(
                            options: MapOptions(
                                center: LatLng(
                                    value.$1.latitude + 0.006, value.$1.longitude),
                                zoom: 14),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://a.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}@2x.png",
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: markers,
                              ),
                              PolylineLayer(
                                polylineCulling: false,
                                polylines: [
                                  Polyline(points: value.$3, color: AppColors.primaryColor, strokeWidth: 3,)
                                ],
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tracking Number",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/sun_icon.png",
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  value.$2.track,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Package Status",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.grey2Color),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: Checkbox(
                                          activeColor: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          side: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 1),
                                          value: value.$2.state?[0],
                                          onChanged: (ind) {}),
                                    ),
                                    const SizedBox(height: 2),
                                    Container(
                                      height: 34,
                                      width: 1,
                                      decoration: BoxDecoration(
                                          color: AppColors.grey2Color),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: Checkbox(
                                            activeColor: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            side: BorderSide(
                                                color: AppColors.primaryColor,
                                                width: 1),
                                            value: value.$2.state?[1],
                                            onChanged: (ind) {}),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Container(
                                      height: 34,
                                      width: 1,
                                      decoration: BoxDecoration(
                                          color: AppColors.grey2Color),
                                    ),
                                    !value.$2.state?[1]
                                        ? Container(
                                            width: 19,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFE0E0E0),
                                                borderRadius:
                                                    BorderRadius.circular(2.3)),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: SizedBox(
                                              width: 14,
                                              height: 14,
                                              child: Checkbox(
                                                  activeColor:
                                                      AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2)),
                                                  side: BorderSide(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1),
                                                  value: value.$2.state?[2],
                                                  onChanged: (ind) {}),
                                            ),
                                          ),
                                    !value.$2.state?[1]
                                        ? const SizedBox(height: 0)
                                        : const SizedBox(height: 2),
                                    Container(
                                      height: 34,
                                      width: 1,
                                      decoration: BoxDecoration(
                                          color: AppColors.grey2Color),
                                    ),
                                    !value.$2.state?[2]
                                        ? Container(
                                            width: 19,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFE0E0E0),
                                                borderRadius:
                                                    BorderRadius.circular(2.3)),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: SizedBox(
                                              width: 14,
                                              height: 14,
                                              child: Checkbox(
                                                  activeColor:
                                                      AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2)),
                                                  side: BorderSide(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1),
                                                  value: value.$2.state?[3],
                                                  onChanged: (ind) {}),
                                            ),
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Courier requested",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: value.$2.state?[0]
                                              ? AppColors.primaryColor
                                              : AppColors.grey2Color),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[0]}${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[0]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(value.$2.createdTime!)
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[0]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Package ready for delivery",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: value.$2.state?[1]
                                              ? AppColors.primaryColor
                                              : AppColors.grey2Color),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[0]}${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[1]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(value.$2.createdTime!)
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[1]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                      "Package in transit",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: value.$2.state?[2]
                                              ? AppColors.primaryColor
                                              : AppColors.grey2Color),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[0]}${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[2]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(value.$2.createdTime!)
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[2]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                      "Package delivered",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: value.$2.state?[3]
                                              ? AppColors.primaryColor
                                              : AppColors.grey2Color),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[0]}${DateFormat.yMMMMd().format(value.$2.createdTime!).split(",")[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[3]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(value.$2.createdTime!)
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: value.$2.state?[3]
                                                  ? AppColors.secondaryColor
                                                  : AppColors.grey2Color),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 46,
                                child: primaryButton("View Package Info", () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmOrderPage(
                                    value.$2.track
                                  )));
                                },
                                    FontWeight.w700, 16))
                          ],
                        ),
                      )
                    ],
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
                      ),
                    ));
  }
}
