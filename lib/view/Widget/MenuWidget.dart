import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constant.dart';

class MenuWidget extends StatelessWidget {
  List<SeassionCard> menu = const [
    SeassionCard(
      route: 'surat',
      title: 'Baca Al-Qur\'an',
      image: 'assets/icons/book.png',
      subTitle: 'Baca dan Dengarkan',
    ),
    SeassionCard(
      route: 'jadwal',
      image: 'assets/icons/pray.png',
      title: 'Jadwal Shalat',
      subTitle: 'Jadwal shalat lengkap',
    ),
    SeassionCard(
      route: '',
      title: 'Qiblat',
      image: 'assets/icons/compas.png',
      subTitle: 'Cari qiblat',
    ),
    SeassionCard(
      route: '',
      image: 'assets/icons/support.png',
      title: 'Support',
      subTitle: 'Support developer',
    ),
  ];

  MenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGreySecondaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  'Menu',
                  style: kPrimaryFontStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: menu.toList(),
              )
            ],
          ),
        ));
  }
}

class SeassionCard extends StatelessWidget {
  final bool isChoose;
  final String image;
  final String title;
  final String subTitle;
  final String route;

  const SeassionCard(
      {Key? key,
      this.isChoose = false,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isChoose ? kSecondaryColor : Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.pushNamed('$route');
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      image,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: kPrimaryFontStyle.copyWith(
                          fontSize: 14,
                          color: isChoose ? Colors.white : kBlackColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MenuCard extends StatelessWidget {
  final bool isChoose;
  final String image;
  final String title;
  final String subTitle;
  final Function function;

  const MenuCard(
      {Key? key,
      this.isChoose = false,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: 70,
        width: size.width / 2 - 24 - 10 - 4,
        margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isChoose ? kSecondaryColor : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 30,
              height: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: kPrimaryFontStyle.copyWith(
                      color: isChoose ? Colors.white : kBlackColor),
                ),
                Text(
                  subTitle,
                  style: kPrimaryFontStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isChoose ? Colors.white70 : Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
