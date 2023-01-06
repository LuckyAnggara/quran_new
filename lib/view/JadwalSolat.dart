import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/provider/read_surat_provider.dart';

import '../provider/provider.dart';

class JadwalSolat extends ConsumerWidget {
  const JadwalSolat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(jadwalProvider);
    final scrollController = ref.watch(jadwalSolatControllerProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text(
            "Jadwal Sholat",
            style: kPrimaryFontStyle,
          ),
        ),
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: data.when(
                          data: (items) {
                            return CustomScrollView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                LiveSliverList(
                                  controller: scrollController,
                                  itemCount: 7,
                                  showItemInterval: Duration(milliseconds: 100),
                                  showItemDuration: Duration(milliseconds: 200),
                                  itemBuilder: (context, index, animation) {
                                    return FadeTransition(
                                        opacity: animation,
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: Offset(0, 0.3),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: JadwalSolatWidget(),
                                        ));
                                  },
                                ),
                              ],
                            );
                          },
                          error: (err, stk) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Column(
                                  children: const [
                                    Icon(Icons.info),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Ada masalah",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          loading: () => Center(
                            child: SpinKitWave(
                              color: kSecondaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class JadwalSolatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(5, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {},
        child: InkWell(
          splashColor: kSecondaryColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "aaa",
                                  style: kPrimaryFontStyle.copyWith(
                                    fontSize: 11,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "aaa",
                                style: kPrimaryFontStyle.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "aaa",
                                style: kPrimaryFontStyle.copyWith(
                                    fontSize: 9,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "aaa",
                          style: kArabicFontAmiri.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.download_outlined,
                            color: kSecondaryColor,
                            size: 26,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.download_outlined,
                          color: kSecondaryColor,
                          size: 26,
                        ),
                      ],
                    ))
                  ],
                ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     LinearPercentIndicator(
                //       padding: const EdgeInsets.symmetric(horizontal: 0),
                //       curve: Curves.bounceIn,
                //       progressColor: kSecondaryColor,
                //       backgroundColor: Colors.grey,
                //       barRadius: Radius.circular(15.0),
                //       animation: true,
                //       lineHeight: 10.0,
                //       animationDuration: 100,
                //       percent: .2,
                //       center: Text(
                //         "20%",
                //         style: kPrimaryFontStyle.copyWith(
                //           fontSize: 8,
                //         ),
                //       ),
                //     ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
