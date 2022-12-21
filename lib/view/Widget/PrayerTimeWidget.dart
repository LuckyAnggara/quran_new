import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../models/jadwal_sholat.dart';
import '../../service/network_service.dart';

final jadwalProvider = FutureProvider<Jadwal>((ref) async {
  return ref.read(apiShalatProvider).getJadwal('0103');
});

class PrayerTimeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(jadwalProvider);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGreySecondaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Row(children: [
              Text(
                'Jadwal Shalat',
                style: kPrimaryFontStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                DateFormat('EEEEE', 'en_US').format(DateTime.now()).toString(),
                textAlign: TextAlign.start,
                style: kPrimaryFontStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
              // Icon(
              //   Icons.open_in_full,
              //   size: 20,
              //   color: kSecondaryColor,
              // )
            ]),
            SizedBox(
              height: 110,
              child: _data.when(
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
                      children: [
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
                  }),
            )
          ],
        ));
  }
}

class PrayerTimeCard extends StatelessWidget {
  final String? time;
  final String? name;

  PrayerTimeCard({Key? key, required this.time, required this.name})
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
            margin: EdgeInsets.only(bottom: 5),
            width: 70,
            height: 80,
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
