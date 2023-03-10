import 'package:flutter/material.dart';

import '../../constant.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onPress;
  final Icon leftIcon;
  final List<RightIconButton>? rightIcon;
  final String title;

  const AppBarWidget(
      {Key? key,
      required this.onPress,
      required this.leftIcon,
      this.rightIcon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: size.height * .05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * .2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onPress,
                child: leftIcon,
              ),
            ),
          ),
          // const Icon(
          //   Icons.menu,
          // ),
          const Spacer(),
          Text(
            title,
            style: kPrimaryFontStyle,
          ),
          const Spacer(),
          SizedBox(
            width: size.width * .2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: rightIcon!.map((e) {
                  return RightIconButton(icon: e.icon, onPress: e.onPress);
                }).toList()),
          )
        ],
      ),
    );
  }
}

class RightIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPress;

  const RightIconButton({super.key, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: SizedBox(
        child: GestureDetector(
          onTap: onPress,
          child: icon,
        ),
      ),
    );
  }
}
