import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/models/surat.dart';
import 'package:reverpod/provider/read_surat_provider.dart';
import 'package:reverpod/router.dart';
import 'package:reverpod/view/Widget/AppBar.dart';
import 'package:reverpod/view/Widget/AyatWidget.dart';
import 'package:reverpod/view/Widget/ModalBottomSheetSetting.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:supercharged/supercharged.dart';

import '../constant.dart';
import '../models/detail_surat.dart';

class ReadSuratPage extends ConsumerStatefulWidget {
  ReadSuratPage({Key? key, required this.surat}) : super(key: key);
  final Surat surat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadSuratPageState();
}

class _ReadSuratPageState extends ConsumerState<ReadSuratPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  void listener() {}
  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(bacaProvider(widget.surat.nomor.toString()));
    final itemScrollController = ref.watch(itemScrollProvider);
    final itemPositionsListener = ref.watch(itemPositionProvider);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ShowCariAyatAlert();
              },
            );
          },
          backgroundColor: kSecondaryColor,
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text(
            "Bismilah",
            style: kPrimaryFontStyle,
          ),
          actions: [
            RightIconButton(
              onPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const ModalFitSetting();
                  },
                );
              },
              icon: Icon(
                Icons.settings,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: _data.when(
                  data: (items) {
                    return items.ayat!.isEmpty
                        ? SliverToBoxAdapter(
                            child: Column(
                              children: const [],
                            ),
                          )
                        : ScrollablePositionedList.builder(
                            physics: const BouncingScrollPhysics(),
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            itemBuilder: (context, index) => AyahWidget(
                              ayat: items.ayat![index],
                            ),
                            itemCount: items.ayat!.length,
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
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [kSecondaryColor.withOpacity(0.8), kSecondaryColor],
        ),
        borderRadius: const BorderRadius.all(
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

class ShowCariAyatAlert extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemScrollController = ref.watch(itemScrollProvider);
    final itemPositionsListener = ref.watch(itemPositionProvider);

    final ayat = ref.watch(cariAyatProvider);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 60,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value == 0 || value == "" || value == null) {
                  ref.read(cariAyatProvider.notifier).state = 1;
                } else {
                  ref.read(cariAyatProvider.notifier).state = int.parse(value);
                }
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cari Ayat',
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            child: ElevatedButton(
              onPressed: () async {
                context.pop();
                itemScrollController
                    .scrollTo(
                  index: ayat - 1,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubic,
                )
                    .then((value) {
                  print(itemPositionsListener.itemPositions.value);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryColor,
                // fixedSize: Size(250, 50),
              ),
              child: Text(
                "Cari",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
