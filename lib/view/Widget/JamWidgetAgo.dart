import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import 'package:timeago/timeago.dart' as timeago;

class JamWidgetAgo extends StatelessWidget {
  JamWidgetAgo({
    Key? key,
    required this.size,
    required this.textColor,
    this.format,
    this.time,
  }) : super(
          key: key,
        );
  final double? size;
  final String? format;
  final DateTime? time;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Text(
            timeago.format(time!, locale: 'id', allowFromNow: true),
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
