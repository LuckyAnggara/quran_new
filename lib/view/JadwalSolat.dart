import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/provider/read_surat_provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:reverpod/view/Widget/JamWidget.dart';
import 'package:reverpod/view/Widget/JamWidgetAgo.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                          data: (post) {
                            return ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                JadwalSolatWidget(
                                    time: post.imsak, name: 'Imsak'),
                                JadwalSolatWidget(
                                    time: post.subuh, name: 'Subuh'),
                                JadwalSolatWidget(
                                    time: post.terbit, name: 'Terbit'),
                                JadwalSolatWidget(
                                    time: post.dhuha, name: 'Dhuha'),
                                JadwalSolatWidget(
                                    time: post.dzuhur, name: 'Dzuhur'),
                                JadwalSolatWidget(
                                    time: post.ashar, name: 'Ashar'),
                                JadwalSolatWidget(
                                    time: post.maghrib, name: 'Maghrib'),
                                JadwalSolatWidget(
                                    time: post.terbit, name: 'Isya'),
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

class JadwalSolatWidget extends ConsumerWidget {
  final String? time;
  final String? name;

  const JadwalSolatWidget({Key? key, required this.time, required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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
                    Text(
                      'Ongoing',
                      style: kPrimaryFontStyle.copyWith(
                        fontSize: 9,
                      ),
                    ),
                    const Spacer(),
                    Transform.scale(
                      scale: 0.75,
                      child: Switch.adaptive(
                        activeColor: kSecondaryColor,
                        value: ref.watch(alarmSholatProvider),
                        onChanged: (val) {
                          ref.read(alarmSholatProvider.notifier).state = val;
                        },
                      ),
                    ),
                    //   AnimatedToggleSwitch<bool>.dual(
                    //     current: alarmSholat,
                    //     first: false,
                    //     second: true,
                    //     dif: 0.1,
                    //     borderColor: Colors.transparent,
                    //     borderWidth: 0.5,
                    //     height: 10,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black26.withOpacity(0.2),
                    //         spreadRadius: 1,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 1.5),
                    //       ),
                    //     ],
                    //     onChanged: (b) {
                    //       ref.read(alarmSholatProvider.notifier).state = b;
                    //     },
                    //     colorBuilder: (b) =>
                    //         b ? kSecondaryColor : kSecondaryColor,
                    //     textBuilder: (value) => value
                    //         ? Center(
                    //             child: Text(
                    //               'On',
                    //               style: kPrimaryFontStyle.copyWith(
                    //                 fontSize: 8,
                    //               ),
                    //             ),
                    //           )
                    //         : Center(
                    //             child: Text(
                    //               'Off',
                    //               style: kPrimaryFontStyle.copyWith(
                    //                 fontSize: 8,
                    //               ),
                    //             ),
                    //           ),
                    //   ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        name!,
                        style: kPrimaryFontStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    JamWidgetAgo(
                      time: DateFormat('yyyy-MM-dd hh:mm')
                          .parse('${formattedDate} ${time!}'),
                      format: "hh:mm",
                      size: 14.0,
                      textColor: Colors.black,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
