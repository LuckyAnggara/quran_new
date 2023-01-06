import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reverpod/provider/read_surat_provider.dart';

import '../constant.dart';
import '../provider/provider.dart';
import '../models/surat.dart';

class SuratPage extends ConsumerWidget {
  SuratPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(suratProvider);
    final play = ref.watch(nowPlayingProvider);
    final scrollController = ref.watch(suratPageControllerProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text(
            "Al Qur'an",
            style: kPrimaryFontStyle,
          ),
        ),
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surat',
                        style: kPrimaryFontStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: data.when(
                          data: (items) {
                            return items.isEmpty
                                ? SliverToBoxAdapter(
                                    child: Column(
                                      children: const [],
                                    ),
                                  )
                                : CustomScrollView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    slivers: [
                                      LiveSliverList(
                                        controller: scrollController,
                                        itemCount: items.length,
                                        showItemInterval:
                                            Duration(milliseconds: 100),
                                        showItemDuration:
                                            Duration(milliseconds: 200),
                                        itemBuilder:
                                            (context, index, animation) {
                                          Surat surat = items[index];

                                          return FadeTransition(
                                              opacity: animation,
                                              child: SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: Offset(0, 0.3),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: SuratWidget(
                                                  surat: surat,
                                                  isPlay: play.id ==
                                                          surat.nomor.toString()
                                                      ? true
                                                      : false,
                                                  context: context,
                                                  ref: ref,
                                                ),
                                              ));
                                        },
                                      ),
                                      //   SliverList(
                                      //     delegate: SliverChildBuilderDelegate(
                                      //         (context, index) {
                                      //       return SuratWidget(
                                      //         surat: surat,
                                      //         isPlay: play.id ==
                                      //                 surat.nomor.toString()
                                      //             ? true
                                      //             : false,
                                      //         context: context,
                                      //         ref: ref,
                                      //       );
                                      //     }, childCount: items.length),
                                      //   )
                                    ],
                                  );
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
                          loading: () => Center(
                            child: SpinKitWave(
                              color: kSecondaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      )
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

  GestureDetector listSurat(
      Surat surat, bool isPlay, BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'baca',
          extra: surat,
        );
      },
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          child: Row(
            children: [
              Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/segi-delapan.svg',
                        color: kSecondaryColor,
                        height: 24,
                        width: 24,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${surat.nomor}",
                            style: kPrimaryFontStyle.copyWith(
                              fontSize: 11,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surat.namaLatin!,
                          style: kPrimaryFontStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          surat.namaLatin!,
                          style: kPrimaryFontStyle.copyWith(
                              fontSize: 9, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    surat.nama!,
                    style: kArabicFontAmiri.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      //     if (!isPlay) {
                      //       ref
                      //           .read(nowPlayingProvider.notifier)
                      //           .setId(surat.nomor.toString());
                      //       ref
                      //           .read(nowPlayingProvider.notifier)
                      //           .setUrl(surat.audio.toString());

                      //       // ref.read(justAudioProvider).when(
                      //       //     data: (play) => play.play(),
                      //       //     error: (error, t) => print(error.toString()),
                      //       //     loading: () => print('loading'));
                      //     } else {
                      //       ref.read(nowPlayingProvider.notifier).setId("0");

                      //       ref.read(nowPlayingProvider.notifier).setUrl("");
                      //     }
                    },
                    child: Icon(
                      isPlay
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_outline,
                      color: kSecondaryColor,
                      size: 26,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    isPlay ? Icons.download : Icons.download_outlined,
                    color: kSecondaryColor,
                    size: 26,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SuratWidget extends StatelessWidget {
  final Surat surat;
  final bool isPlay;
  final BuildContext context;
  final WidgetRef ref;

  const SuratWidget(
      {super.key,
      required this.surat,
      required this.isPlay,
      required this.context,
      required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(5, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            'baca',
            extra: surat,
          );
        },
        child: InkWell(
          splashColor: kSecondaryColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/segi-delapan.svg',
                              color: kSecondaryColor,
                              height: 24,
                              width: 24,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${surat.nomor}",
                                  style: kPrimaryFontStyle.copyWith(
                                    fontSize: 11,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surat.namaLatin!,
                                style: kPrimaryFontStyle.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                surat.namaLatin!,
                                style: kPrimaryFontStyle.copyWith(
                                    fontSize: 9,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          surat.nama!,
                          style: kArabicFontAmiri.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            isPlay
                                ? Icons.pause_circle_filled_outlined
                                : Icons.play_circle_outline,
                            color: kSecondaryColor,
                            size: 26,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          isPlay ? Icons.download : Icons.download_outlined,
                          color: kSecondaryColor,
                          size: 26,
                        ),
                      ],
                    ))
                  ],
                ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     LinearPercentIndicator(
                //       padding: const EdgeInsets.symmetric(horizontal: 0),
                //       curve: Curves.bounceIn,
                //       progressColor: kSecondaryColor,
                //       backgroundColor: Colors.grey,
                //       barRadius: Radius.circular(15.0),
                //       animation: true,
                //       lineHeight: 10.0,
                //       animationDuration: 100,
                //       percent: .2,
                //       center: Text(
                //         "20%",
                //         style: kPrimaryFontStyle.copyWith(
                //           fontSize: 8,
                //         ),
                //       ),
                //     ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
