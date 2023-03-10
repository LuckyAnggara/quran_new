import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';

class ClockWidget extends StatelessWidget {
  ClockWidget(
      {Key? key, required this.size, required this.textColor, this.format})
      : super(
          key: key,
        );
  final double? size;
  final String? format;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Text(
            DateFormat('${format}').format(DateTime.now()),
            style: kPrimaryFontStyle.copyWith(
              fontSize: size ?? 24,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          );
        },
      ),
    );
  }
}
