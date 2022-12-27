import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/constant.dart';
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: kSecondaryColor.withOpacity(1),
            label: const Text('Simpan'),
            icon: const Icon(Icons.save),
          ),
          backgroundColor: kPrimaryColor,
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              children: [
                AppBarWidget(
                  onPress: () {
                    context.pop();
                  },
                  leftIcon: Icon(Icons.arrow_back_ios),
                  title: 'Font Size',
                  rightIcon: [],
                ),
                SizedBox(
                  child: TabBar(
                    tabs: [
                      Text(
                        'Arabic',
                        style: kPrimaryFontStyle,
                      ),
                      Text('Latin', style: kPrimaryFontStyle),
                      Text('Terjemahan', style: kPrimaryFontStyle),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: const TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [PanelArabic(), PanelLatin(), PanelTerjemahan()],
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(arabicSizeProvider);
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
              max: 60.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref.read(arabicSizeProvider.notifier).update((state) => value);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(latinSizeProvider);
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
              child: Html(
                data:
                    """bismi <strong>al</strong>l<u>aa</u>hi <strong>al</strong>rra<u>h</u>m<u>aa</u>ni <strong>al</strong>rra<u>h</u>iim<strong>i</strong>""",
                style: {
                  "body": Style(
                    fontSize: FontSize(
                      fontSize,
                    ),
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SfSlider(
              min: 10.0,
              max: 60.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref.read(latinSizeProvider.notifier).update((state) => value);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(translateSizeProvider);

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
              "Dengan nama Allah Yang Maha Pengasih, Maha Penyayang",
              textAlign: TextAlign.start,
              style: kPrimaryFontStyle.copyWith(fontSize: fontSize, fontWeight: FontWeight.w500),
            )),
          ),
          SizedBox(
            width: double.infinity,
            child: SfSlider(
              min: 10.0,
              max: 60.0,
              value: fontSize,
              interval: 10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 0,
              stepSize: 1.0,
              onChanged: (dynamic value) {
                ref.read(translateSizeProvider.notifier).update((state) => value);
              },
            ),
          )
        ],
      ),
    );
  }
}
