import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/home/presentation/states/home_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/states/main_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final supabase = Supabase.instance.client;
  late Color color;
  late double padding;
  late double textWidth;
  late User? user;
  int currentTab = 6;

  @override
  void initState() {
    super.initState();
    if (supabase.auth.currentUser != null) {
      if (supabase.auth.currentUser?.appMetadata["provider"] == "google") {
        ref.read(userProvider.notifier).saveUser();
      }
      user = supabase.auth.currentUser;
    }
    color = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(homeProvider).data;
    user = supabase.auth.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.grey1Color),
                  child: TextFormField(
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
                      hintText: "Search Services",
                      hintStyle:
                          TextStyle(fontSize: 12, color: AppColors.grey2Color),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Stack(
                  children: [
                    Image.asset("assets/images/home_start.png"),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 12, right: 17),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello ${user?.userMetadata?["name"]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                              const Text(
                                "We trust you are having a great time",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/images/notif_icon.png",
                            width: 24,
                            height: 24,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      "Special for you",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    ),
                    const Spacer(),
                    Image.asset(
                      "assets/images/arrow_right_icon.png",
                      width: 14,
                      height: 14,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ref.watch(imagesProvider).when(
                    data: (value) {
                      return SizedBox(
                        height: 64,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            if (index == 1) {
                              color = AppColors.warningColor;
                            } else if (index == 4) {
                              color = const Color(0xFF630202);
                            } else {
                              color = Colors.white;
                            }
                            if (index == 0) {
                              padding = 6;
                            } else if (index == 4) {
                              padding = 53;
                            } else if (index == 3) {
                              padding = 15;
                            } else {
                              padding = 46;
                            }
                            if (index == 3) {
                              textWidth = 138;
                            } else {
                              textWidth = 70;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: value[index].image,
                                    width: 166,
                                    height: 64,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: index == 3 || index == 4 ? 26 : 16,
                                        left: padding),
                                    child: SizedBox(
                                      width: textWidth,
                                      child: Text(
                                        value[index].title ?? "",
                                        style:
                                            TextStyle(fontSize: 12, color: color),
                                        textAlign:
                                            index == 1 ? TextAlign.center : null,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
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
                const SizedBox(height: 29),
                Text(
                  "What would you like to do",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 370,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 23,
                        mainAxisSpacing: 23,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentTab = index;
                          });
                        },
                        child: Material(
                          elevation: 2,
                          color: currentTab == index ? AppColors.primaryColor : AppColors.grey6Color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 28, left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  currentTab == index
                                      ? data[index][3]
                                      : data[index][2],
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  data[index][0],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: currentTab == index
                                          ? Colors.white
                                          : AppColors.primaryColor),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 127,
                                  child: Text(
                                    data[index][1],
                                    style: TextStyle(
                                        fontSize: 7.542,
                                        color: currentTab == index
                                            ? Colors.white
                                            : AppColors.textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
