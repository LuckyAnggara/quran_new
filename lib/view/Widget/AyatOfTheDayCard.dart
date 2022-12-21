import 'package:flutter/material.dart';

import '../../constant.dart';

class AyatOfTheDayCard extends StatelessWidget {
  const AyatOfTheDayCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 1,
      right: 1,
      left: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        width: double.infinity,
        // height: Get.height * .207,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              child: Text(
                "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ النَّاسِ",
                textAlign: TextAlign.right,
                style: kArabicFontAmiri.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Text(
              "Katakanlah: \"Aku berlindung kepada Tuhan (yang memelihara dan menguasai) manusia.",
              textAlign: TextAlign.start,
              style: kPrimaryFontStyle.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w200),
            ),
            Divider(
              thickness: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/light.png',
                      width: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Al-Fatihah - Ayat 05",
                          style: kPrimaryFontStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Ayat hari ini",
                          style: kPrimaryFontStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow_outlined,
                        color: kSecondaryColor,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.share_outlined,
                        color: kSecondaryColor,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.bookmark_outline,
                        color: kSecondaryColor,
                        size: 24,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
