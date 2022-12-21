import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Text(
            DateFormat('hh:mm:ss').format(DateTime.now()),
            style: kPrimaryWhiteFontStyle.copyWith(fontSize: 24),
          );
        },
      ),
    );
  }
}
