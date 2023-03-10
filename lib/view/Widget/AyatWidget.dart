import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/models/detail_surat.dart';
import 'package:reverpod/provider/provider.dart';

class AyahWidget extends ConsumerWidget {
  final Ayat ayat;

  AyahWidget({
    required this.ayat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setting(string) =>
        ref.watch(settingNotifierProvider).setting.getBool(string);
    fontSize(string) =>
        ref.watch(settingNotifierProvider).setting.getDouble(string);

    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColorMoreBlack.withOpacity(0.15),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //ARAB
                setting('arabicShow')
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: Text(
                          ayat.ar.toString(),
                          textAlign: TextAlign.end,
                          style: kArabicFontAmiri.copyWith(
                              fontSize: fontSize('arabicFontSize'),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : SizedBox(),
                //Latin
                setting('latinShow')
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Text(
                          ayat.tr.toString(),
                          textAlign: TextAlign.start,
                          style: kPrimaryFontStyle.copyWith(
                              color: Colors.green,
                              fontSize: fontSize('latinFontSize'),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : const SizedBox(),
                //Translate
                setting('translateShow')
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(
                          ayat.idn.toString(),
                          textAlign: TextAlign.start,
                          style: kPrimaryFontStyle.copyWith(
                              fontSize: fontSize('translateFontSize'),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: kSecondaryColorMoreBlack.withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(45),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      ayat.nomor.toString(),
                      style: kPrimaryWhiteFontStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
