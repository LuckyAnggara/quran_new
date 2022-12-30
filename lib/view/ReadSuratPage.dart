import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/models/surat.dart';
import 'package:reverpod/router.dart';
import 'package:reverpod/view/Widget/AppBar.dart';
import 'package:reverpod/view/Widget/AyatWidget.dart';
import 'package:reverpod/view/Widget/ModalBottomSheetSetting.dart';

import '../constant.dart';
import '../models/detail_surat.dart';

class ReadSuratPage extends ConsumerWidget {
  const ReadSuratPage({Key? key, required this.surat}) : super(key: key);

  final Surat surat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(bacaProvider(surat.nomor.toString()));

    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              AppBarWidget(
                onPress: () {
                  router.pop();
                },
                leftIcon: const Icon(
                  Icons.arrow_back_ios,
                ),
                title: 'Baca surat ${surat.namaLatin.toString()}',
                rightIcon: [
                  RightIconButton(
                    onPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ModalFitSetting();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: kSecondaryColor,
                    ),
                  ),
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
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return CardDetailSurah(surat: surat);
                                }, childCount: 1),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  Ayat ayat = items.ayat![index];
                                  return AyahWidget(ayat: ayat);
                                }, childCount: items.ayat!.length),
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
      ),
    );
  }
}

class CardDetailSurah extends ConsumerWidget {
  const CardDetailSurah({Key? key, required this.surat}) : super(key: key);

  final Surat surat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [kSecondaryColor.withOpacity(0.8), kSecondaryColor],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            surat.nama!,
            style: kPrimaryWhiteFontStyle.copyWith(
                fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1.2),
          ),
          Text(
            surat.namaLatin!,
            style: kPrimaryWhiteFontStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                surat.tempatTurun!,
                style: kPrimaryWhiteFontStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1),
              ),
              Text(
                ' - ',
                style: kPrimaryWhiteFontStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1),
              ),
              Text(
                '${surat.jumlahAyat!} Ayat',
                style: kPrimaryWhiteFontStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1),
              ),
            ],
          ),
          Divider(
            thickness: 1.0,
            color: Colors.white54,
          ),
          SizedBox(
            height: 5,
          ),
          Image.asset(
            'assets/card/bismilah.png',
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}

class ModalFit extends StatelessWidget {
  const ModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Edit'),
            leading: Icon(Icons.edit),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Copy'),
            leading: Icon(Icons.content_copy),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Cut'),
            leading: Icon(Icons.content_cut),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Move'),
            leading: Icon(Icons.folder_open),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Delete'),
            leading: Icon(Icons.delete),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
    ));
  }
}
