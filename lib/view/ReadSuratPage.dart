import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod/controller/AudioController.dart';
import 'package:reverpod/controller/SuratController.dart';
import 'package:reverpod/router.dart';
import 'package:reverpod/view/Widget/AppBar.dart';

import '../constant.dart';
import '../models/detail_surat.dart';

class ReadSuratPage extends ConsumerWidget {
  ReadSuratPage({Key? key, required this.nomor, required this.namaLatin}) : super(key: key);

  final String? nomor;
  final String? namaLatin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(bacaProvider(nomor!));
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kSecondaryColor.withOpacity(1),
          child: const Icon(
            Icons.more_horiz,
          ),
        ),
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              AppBarWidget(
                onPress: () {
                  ref.invalidate(bacaProvider);
                  router.go('/surat');
                },
                leftIcon: const Icon(Icons.arrow_back_ios),
                title: namaLatin.toString(),
                rightIcon: [
                  RightIconButton(
                    onPress: () {
                      ref.read(audioPlayerProvider(_data.value!.audio!));
                    },
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
                ], // rightIcon: [],
              ),
              Expanded(
                child: _data.when(
                  data: (items) {
                    return items.ayat!.isEmpty
                        ? SliverToBoxAdapter(
                            child: Column(
                              children: const [],
                            ),
                          )
                        : CustomScrollView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate((context, index) {
                                  Ayat ayat = items.ayat![index];
                                  return AyahWidget(ayat: ayat);
                                }, childCount: items.ayat!.length),
                              )
                            ],
                          );
                    // return SingleChildScrollView(
                    //   physics: const BouncingScrollPhysics(),
                    //   scrollDirection: Axis.vertical,
                    //   child: Column(
                    //     children: List.generate(_data.ayat!.length, (index) {
                    //       Ayat ayat = _data.ayat![index];
                    //       return AyahWidget(ayat: ayat, onPlay: () {});
                    //     }),
                    //   ),
                    // );
                  },
                  error: (err, stk) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: const [
                            Icon(Icons.info),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ada masalah",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
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

class AyahWidget extends StatelessWidget {
  final Ayat ayat;

  AyahWidget({
    required this.ayat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColorMoreBlack.withOpacity(0.15),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              children: [
                //ARAB
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  child: Text(
                    ayat.ar.toString(),
                    textAlign: TextAlign.end,
                    style: kArabicFontAmiri.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                //Latin
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  child: Html(
                    data: """${ayat.tr}""",
                    style: {
                      "body": Style(
                        fontSize: FontSize(14),
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  ),

                  // Text(
                  //   ayat.tr,
                  //   textAlign: TextAlign.end,
                  //   style: kArabicFontAmiri.copyWith(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black),
                  // ),
                ),
                //Translate
                Container(
                  width: double.infinity,
                  child: Text(
                    ayat.idn.toString(),
                    textAlign: TextAlign.start,
                    style: kPrimaryFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: kSecondaryColorMoreBlack.withOpacity(0.15),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(45),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      ayat.nomor.toString(),
                      style: kPrimaryWhiteFontStyle,
                    ),
                  ),
                ),
                Spacer(),

                // GetBuilder(
                //     init: readQuranController,
                //     id: 'updatePlay',
                //     builder: (context) {
                //       if (readQuranController.playIndex.toString() !=
                //           ayat.nomor.toString()) {
                //         if (readQuranController
                //             .isStateLoadingAudio.value) {
                //           return SpinKitCircle(
                //             size: 14,
                //             color: kSecondaryColor,
                //           );
                //         } else {
                //           return GestureDetector(
                //             onTap: onPlay,
                //             child: Icon(
                //               Icons.play_circle_outline,
                //               color: kSecondaryColor,
                //             ),
                //           );
                //         }
                //       } else {
                //         return GestureDetector(
                //           onTap: () {
                //             readQuranController.pauseAudio();
                //           },
                //           child: Icon(
                //             Icons.pause_circle_filled,
                //             color: kSecondaryColor,
                //           ),
                //         );
                //       }
                //     }),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.share_outlined,
                  color: kSecondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Expanded(
// child: _data.when(
// data: (_data) {
// return SingleChildScrollView(
// physics: const BouncingScrollPhysics(),
// scrollDirection: Axis.vertical,
// child: Column(
// children: List.generate(_data.ayat!.length, (index) {
// Ayat ayat = _data.ayat![index];
// return AyahWidget(ayat: ayat, onPlay: () {});
// }),
// ),
// );
// },
// error: (err, s) {
// return Text(err.toString());
// },
// loading: () => const Center(
// child: CircularProgressIndicator(),
// ),
// ),
// )
