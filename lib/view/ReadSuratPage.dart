import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/controller/SuratController.dart';

import 'package:reverpod/view/Widget/AppBar.dart';

import '../constant.dart';
import '../models/detail_surat.dart';

class ReadSuratPage extends ConsumerWidget {
  ReadSuratPage({Key? key, required this.nomor}) : super(key: key);

  final String? nomor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(bacaProvider(nomor!));
    print(_data.value);
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
                onPress: () {},
                leftIcon: const Icon(Icons.arrow_back_ios),
                title: nomor.toString(),
                rightIcon: const [
                  Icon(Icons.bookmark_outline),
                  Icon(Icons.settings_outlined),
                ],
                // rightIcon: [],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // const CardDetailSurah(),
                      const SizedBox(
                        height: 20,
                      ),

                      _data.when(
                        data: (_data) {
                          return ListView.separated(
                            separatorBuilder: (context, int) {
                              return const Divider();
                            },
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: _data.ayat!.length,
                            itemBuilder: (context, index) {
                              return AyahWidget(
                                onPlay: () {},
                                ayat: _data.ayat![index],
                              );
                            },
                          );
                        },
                        error: (err, s) => Text(err.toString()),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      // GetBuilder(
                      //     init: readQuranController,
                      //     id: 'updateListAyat',
                      //     builder: (context) {
                      //       if (readQuranController.isLoading.value) {
                      //         return Center(
                      //           child: SpinKitWave(
                      //             color: kSecondaryColor,
                      //           ),
                      //         );
                      //       } else {
                      //         var data = readQuranController.surat.value;
                      //         var dataAudio =
                      //             readQuranController.audio.value?.data?[0];
                      //         // var dataTranslate =
                      //         //     readQuranController.surat.value!.data![2];
                      //
                      //         return Column(
                      //           children: List.generate(
                      //               readQuranController.pageSize.value,
                      //               (index) {
                      //             return AyahWidget(
                      //               onPlay: () {
                      //                 readQuranController.playAudio(
                      //                   dataAudio!.ayahs![index].audio!,
                      //                   dataAudio.ayahs![index].numberInSurah!,
                      //                 );
                      //               },
                      //               ayat: data!.ayat[index],
                      //             );
                      //           }).toList(),
                      //         );
                      //       }
                      //     })
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

class AyahWidget extends StatelessWidget {
  final Ayat ayat;
  // final Ayah? ayahTranslate;
  final VoidCallback onPlay;

  AyahWidget({
    required this.ayat,
    // this.ayahTranslate,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: readQuranController.playIndex.toString() != ayat.nomor.toString()
            ? Colors.transparent
            : kSecondaryColorMoreBlack.withOpacity(0.15),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              children: [
                //ARAB
                settingController.arabic
                    ? Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        child: Text(
                          ayat.ar,
                          textAlign: TextAlign.end,
                          style: kArabicFontAmiri.copyWith(
                              fontSize: settingController.fontSizeArabic,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : SizedBox(),
                //Latin
                settingController.latin
                    ? Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        child: Html(
                          data: """${ayat.tr}""",
                          style: {
                            "body": Style(
                              fontSize:
                                  FontSize(settingController.fontSizeLatin),
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
                      )
                    : SizedBox(),
                //Translate
                settingController.terjemahan
                    ? Container(
                        width: double.infinity,
                        child: Text(
                          ayat.idn,
                          textAlign: TextAlign.start,
                          style: kPrimaryFontStyle.copyWith(
                              fontSize: settingController.fontSizeTerjemahan,
                              fontWeight: FontWeight.w500),
                        ))
                    : SizedBox(),
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
//
// class CardDetailSurah extends StatelessWidget {
//   const CardDetailSurah({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 60, vertical: 24),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight,
//           colors: [kSecondaryColor.withOpacity(0.8), kSecondaryColor],
//         ),
//         borderRadius: BorderRadius.all(
//           Radius.circular(12),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             Get.arguments['name'],
//             style: kPrimaryWhiteFontStyle.copyWith(
//                 fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1.2),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             Get.arguments['translation'],
//             style: kPrimaryWhiteFontStyle.copyWith(
//                 fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 1),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 Get.arguments['revelation'],
//                 style: kPrimaryWhiteFontStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 1),
//               ),
//               Text(
//                 ' - ',
//                 style: kPrimaryWhiteFontStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 1),
//               ),
//               Text(
//                 '${Get.arguments['ayat']} Ayat',
//                 style: kPrimaryWhiteFontStyle.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal,
//                     letterSpacing: 1),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Divider(
//             thickness: 1.0,
//             color: Colors.white54,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Image.asset(
//             'assets/card/bismilah.png',
//             color: Colors.white70,
//           ),
//         ],
//       ),
//     );
//   }
// }

// child: GetBuilder<QuranController>(
//     init: quranController,
//     builder: (context) {
//       SuratModelSatuan? surat = quranController.surat.value;
//       return Column(
//         children: [
//           AppBarWidget(
//             onPress: () {
//               Get.back();
//             },
//             leftIcon: Icon(Icons.arrow_back_ios),
//             title: 'aa',
//             rightIcon: [
//               Icon(Icons.bookmark_outline),
//               Icon(Icons.settings_outlined),
//             ],
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: quranController.isLoadingSatuan.value
//                   ? SpinKitWave(
//                       color: kSecondaryColor,
//                     )
//                   : Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   surat!.name!.short!,
//                                   style: kArabicFontAmiri.copyWith(
//                                       fontSize: 30, fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   surat.name!.transliteration!.id!,
//                                   style: kPrimaryFontStyle.copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: double.infinity,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 surat.revelation!.id!,
//                                 style: kSecondaryGreyFontStyle.copyWith(fontSize: 12),
//                               ),
//                               Spacer(),
//                               Text(
//                                 'berjumlah ${surat.numberOfVerses!} ayat',
//                                 style: kSecondaryGreyFontStyle.copyWith(fontSize: 12),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(15),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: surat.verses!.map((e) {
//                               return Container(
//                                 width: double.infinity,
//                                 child: Text(
//                                   textAlign: TextAlign.right,
//                                   e.text!.arab!,
//                                   style: kArabicFontAmiri.copyWith(
//                                       fontSize: 40, fontWeight: FontWeight.w500),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         )
//                       ],
//                     ),
//             ),
//           )
//         ],
//       );
//     })),
