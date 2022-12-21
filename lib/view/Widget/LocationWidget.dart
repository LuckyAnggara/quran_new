import 'package:flutter/material.dart';

import '../../constant.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Location',
                style: kPrimaryFontStyle,
              ),
              Text(
                'BANDUNG',
                style: kSecondaryFontStyle,
              ),
            ],
          ),
          SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.location_pin,
              size: 18,
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
