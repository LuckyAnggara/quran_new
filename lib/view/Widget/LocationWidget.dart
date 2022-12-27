import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant.dart';
import '../../controller/StorageController.dart';

class LocationWidget extends StatelessWidget {
  final String location = 'Bandung';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.location_pin,
              size: 14,
              color: kSecondaryColor,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          location.isEmpty
              ? Text(
                  'My Location',
                  style: kPrimaryFontStyle,
                )
              : Text(
                  'BANDUNG',
                  style: kSecondaryFontStyle,
                ),
        ],
      ),
    );
  }
}
