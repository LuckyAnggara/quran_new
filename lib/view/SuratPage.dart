import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constant.dart';
import '../controller/SuratController.dart';
import '../models/surat.dart';
import 'Widget/AppBar.dart';

class SuratPage extends ConsumerWidget {
  const SuratPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(suratProvider);
    return SafeArea(
      child: Scaffold(
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: () {},
        //     backgroundColor: kSecondaryColor.withOpacity(1),
        //     child: const Icon(
        //       Icons.search,
        //       size: 30,
        //     ),
        //   ),
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              AppBarWidget(
                onPress: () {
                  context.pop();
                },
                leftIcon: const Icon(Icons.arrow_back_ios),
                title: 'Al Qur\'an',
                rightIcon: const [],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terakhir dibaca',
                      style: kPrimaryFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 25,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            // return lastReadContainer();
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surat',
                        style: kPrimaryFontStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: _data.when(
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
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate((context, index) {
                                          Surat surat = items[index];
                                          if (index == 2) {
                                            return listSurat(surat, true, context);
                                          }
                                          return listSurat(surat, false, context);
                                        }, childCount: items.length),
                                      )
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
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
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

  GestureDetector listSurat(Surat surat, bool isPlay, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('baca',
            params: {'nomor': surat.nomor.toString(), 'namaLatin': surat.namaLatin.toString()});

        //     params: {
        //   'number': surat.nomor.toString(),
        //   'name': surat.namaLatin!,
        //   'translation': surat.arti!,
        //   'revelation': surat.tempatTurun!,
        //   'ayat': surat.jumlahAyat.toString()
        // });
        // Get.toNamed(
        //   '/read-quran/${surat.nomor}',
        //   arguments: {
        //     'number': surat.nomor,
        //     'name': surat.namaLatin,
        //     'translation': surat.arti,
        //     'revelation': surat.tempatTurun,
        //     'ayat': surat.jumlahAyat
        //   },
        // );
      },
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    surat.nomor.toString(),
                    style: kPrimaryFontStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 105,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surat.namaLatin!,
                          style: kPrimaryFontStyle.copyWith(fontSize: 14, letterSpacing: 1.2),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        AutoSizeText(
                          surat.arti!,
                          style: kSecondaryGreyFontStyle.copyWith(
                            fontSize: 5,
                          ),
                          maxLines: 2,
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
                    style: kArabicFontAmiri.copyWith(fontSize: 14, letterSpacing: 1.2),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(
                    isPlay ? Icons.pause_circle_filled_outlined : Icons.play_circle_outline,
                    color: kSecondaryColor,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    isPlay ? Icons.download : Icons.download,
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
//
// Container lastReadContainer() {
//   return Container(
//     margin: EdgeInsets.only(right: 15),
//     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       border: Border.all(color: kSecondaryColor),
//       borderRadius: BorderRadius.all(
//         Radius.circular(5),
//       ),
//     ),
//     child: Text(
//       'Al-Fatihah',
//       style: kSecondaryGreyFontStyle.copyWith(fontSize: 12),
//     ),
//   );
// }
}
