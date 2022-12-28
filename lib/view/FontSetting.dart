import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/models/setting.dart';
import 'package:reverpod/provider/setting_provider.dart';
import 'package:reverpod/view/Widget/AppBar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FontSizeScreenSetting extends StatelessWidget {
  const FontSizeScreenSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            title: Text(
              'Font Setting',
              style: kPrimaryFontStyle,
            ),
          ),
          backgroundColor: kPrimaryColor,
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  child: TabBar(
                    tabs: [
                      Text(
                        'Arabic',
                        style: kPrimaryFontStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        'Latin',
                        style: kPrimaryFontStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        'Terjemahan',
                        style: kPrimaryFontStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PanelArabic(),
                        PanelLatin(),
                        PanelTerjemahan()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PanelArabic extends ConsumerWidget {
  const PanelArabic({super.key});

  final string = 'arabicFontSize';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize =
        ref.watch(settingNotifierProvider).setting.getDouble(string);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: const Text('Arabic'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Center(
              child: Text(
                "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ النَّاسِ",
                style: kArabicFontAmiri.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SfSlider(
              min: 10.0,
              max: 40.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref
                    .read(settingNotifierProvider.notifier)
                    .updateKeyDouble(string, value);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PanelLatin extends ConsumerWidget {
  const PanelLatin({super.key});

  final string = 'latinFontSize';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize =
        ref.watch(settingNotifierProvider).setting.getDouble(string);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: const Text('Latin'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Center(
              child: Html(
                data:
                    """bismi <strong>al</strong>l<u>aa</u>hi <strong>al</strong>rra<u>h</u>m<u>aa</u>ni <strong>al</strong>rra<u>h</u>iim<strong>i</strong>""",
                style: {
                  "body": Style(
                    fontSize: FontSize(
                      fontSize,
                    ),
                    color: Colors.brown,
                  ),
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SfSlider(
              min: 10.0,
              max: 40.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref
                    .read(settingNotifierProvider.notifier)
                    .updateKeyDouble(string, value);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PanelTerjemahan extends ConsumerWidget {
  const PanelTerjemahan({super.key});

  final string = 'transalteFontSize';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize =
        ref.watch(settingNotifierProvider).setting.getDouble(string);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: const Text('Terjemahan'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Center(
              child: Text(
                "Dengan nama Allah Yang Maha Pengasih, Maha Penyayang",
                textAlign: TextAlign.start,
                style: kPrimaryFontStyle.copyWith(
                    fontSize: fontSize, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SfSlider(
              min: 10.0,
              max: 40.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref
                    .read(settingNotifierProvider.notifier)
                    .updateKeyDouble(string, value);
              },
            ),
          )
        ],
      ),
    );
  }
}
