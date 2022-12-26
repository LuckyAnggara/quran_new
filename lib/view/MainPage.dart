import 'package:flutter/material.dart';
import 'package:reverpod/view/Widget/LocationWidget.dart';
import 'package:reverpod/view/Widget/PrayerTimeWidget.dart';

import '../constant.dart';
import 'Widget/AppBar.dart';
import 'Widget/AyatOfTheDayCard.dart';
import 'Widget/DateCardWidget.dart';
import 'Widget/MenuWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              AppBarWidget(
                onPress: () {},
                leftIcon: const Icon(Icons.dashboard_outlined),
                title: 'Home',
                rightIcon: [
                  RightIconButton(
                    onPress: () {},
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: kSecondaryColor,
                    ),
                  ),
                  RightIconButton(
                    onPress: () {},
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const LocationWidget(),
                      SizedBox(
                        height: size.height * .50,
                        width: size.width,
                        child: Stack(
                          children: [
                            DateCardWidget(),
                            AyatOfTheDayCard(),
                          ],
                        ),
                      ),
                      PrayerTimeWidget(),
                      const SizedBox(
                        height: 50,
                      ),
                      MenuWidget()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
