import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/data/models/rider_model.dart';
import 'package:oech_app/home/presentation/pages/rider_profile_page.dart';
import 'package:oech_app/home/presentation/states/riders_state.dart';

import '../../../core/theme/colors.dart';

class BookRiderPage extends ConsumerWidget {
  BookRiderPage({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<RiderModel> data = ref.watch(ridersProvider).data;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
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
          "Book a rider",
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
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ref.watch(ridersProvider).isColor
                      ? Colors.white
                      : AppColors.grey1Color),
              child: TextFormField(
                onChanged: (value) {
                  ref.refresh(getRidersProvider(value)).value;
                },
                onTap: () {
                  ref.read(ridersProvider.notifier).changeFocus(true);
                },
                controller: controller,
                style: TextStyle(fontSize: 12, color: AppColors.textColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 12),
                  suffixIcon: SizedBox(
                      width: 12,
                      height: 12,
                      child: Image.asset(
                        "assets/images/search_icon.png",
                        fit: BoxFit.scaleDown,
                        scale: 3,
                      )),
                  hintText: "Search for a driver",
                  hintStyle:
                      TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  border: OutlineInputBorder(
                    borderSide: ref.watch(ridersProvider).isColor
                        ? BorderSide(width: 1, color: AppColors.grey2Color)
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.grey2Color),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ref.watch(getRidersProvider(controller.text)).when(
                  data: (value) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RiderProfilePage(
                                          value[index].regNum)));
                            },
                            child: Material(
                              elevation: 2,
                              color: Colors.white,
                              child: SizedBox(
                                height: 84,
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: data[index].avatar,
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
                                          data[index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textColor),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          data[index].regNum,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textColor),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 9,
                                      width: 80,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (context, curIndex) {
                                          return int.parse(data[index].rate) >
                                                  curIndex
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      right: curIndex == 4
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
                                                      right: curIndex == 4
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
                              ),
                            ),
                          ),
                        );
                      },
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
            ),
          ],
        ),
      ),
    );
  }
}
