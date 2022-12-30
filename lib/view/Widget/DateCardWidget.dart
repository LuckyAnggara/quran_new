import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:reverpod/helper.dart';

import '../../constant.dart';
import 'JamWidget.dart';

class DateCardWidget extends StatelessWidget {
  const DateCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage(
              'assets/card/mosque1.jpg',
            ),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop)),
        color: Colors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      width: double.infinity,
      height: size.height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(formatTglIndo(DateTime.now().toString()),
                  style: kPrimaryWhiteFontStyle),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ClockWidget(
                  size: 36,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Magrib dalam 5 Menit',
                  style: kPrimaryWhiteFontStyle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
