import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reverpod/helper.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/provider/read_surat_provider.dart';

import '../../constant.dart';
import '../../models/jadwal_sholat.dart';
import '../../service/network_service.dart';

class PrayerTimeWidget extends ConsumerWidget {
  const PrayerTimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(jadwalProvider);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGreySecondaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Row(children: [
              Text(
                'Jadwal Shalat Hari Ini',
                style: kPrimaryFontStyle.copyWith(
                    fontSize: 13, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.goNamed('jadwal-sholat');
                },
                child: Icon(
                  Icons.open_in_new,
                  color: Colors.black54,
                  size: 18,
                ),
              )
            ]),
            SizedBox(
              height: 100,
              child: data.when(
                data: (post) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      PrayerTimeCard(time: post.imsak, name: 'Imsak'),
                      PrayerTimeCard(time: post.subuh, name: 'Subuh'),
                      PrayerTimeCard(time: post.terbit, name: 'Terbit'),
                      PrayerTimeCard(time: post.dhuha, name: 'Dhuha'),
                      PrayerTimeCard(time: post.dzuhur, name: 'Dzuhur'),
                      PrayerTimeCard(time: post.ashar, name: 'Ashar'),
                      PrayerTimeCard(time: post.maghrib, name: 'Maghrib'),
                      PrayerTimeCard(time: post.isya, name: 'Isya'),
                    ],
                  );
                },
                error: (err, s) => Text(err.toString()),
                loading: () {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: const [
                      PrayerTimeCard(time: null, name: 'Imsak'),
                      PrayerTimeCard(time: null, name: 'Subuh'),
                      PrayerTimeCard(time: null, name: 'Terbit'),
                      PrayerTimeCard(time: null, name: 'Dhuha'),
                      PrayerTimeCard(time: null, name: 'Dzuhur'),
                      PrayerTimeCard(time: null, name: 'Ashar'),
                      PrayerTimeCard(time: null, name: 'Maghrib'),
                      PrayerTimeCard(time: null, name: 'Isya'),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}

class PrayerTimeCard extends StatelessWidget {
  final String? time;
  final String? name;

  const PrayerTimeCard({Key? key, required this.time, required this.name})
      : super(key: key);

  // var dt = DateTime.now();
  // bool isPast = false;

  @override
  Widget build(BuildContext context) {
    // var timeDt = DateFormat('hh').parse(time!);

    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: 50,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: time != null
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      time!,
                      style: kPrimaryWhiteFontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                : SpinKitWave(
                    color: kSecondaryColor,
                    size: 24,
                  ),
          ),
          Text(
            name!,
            style: kPrimaryFontStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
