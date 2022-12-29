import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/models/kota.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/provider/setting_provider.dart';

import '../../constant.dart';

class LocationWidget extends ConsumerWidget {
  final String location = 'Bandung';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(namaKotaProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          context.pushNamed('kota');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              Icons.location_pin,
              size: 16,
              color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            data.when(
              data: (kota) {
                return Text(
                  '${kota.lokasi}',
                  style: kSecondaryFontStyle,
                );
              },
              error: (err, k) {
                return Text(err.toString());
              },
              loading: () => Center(
                child: SpinKitWave(
                  color: kSecondaryColor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
