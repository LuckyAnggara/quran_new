import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/models/surat.dart';
import 'package:reverpod/router.dart';
import 'package:reverpod/view/Widget/AppBar.dart';
import 'package:reverpod/view/Widget/AyatWidget.dart';
import 'package:reverpod/view/Widget/ModalBottomSheet.dart';

import '../constant.dart';
import '../models/detail_surat.dart';

class ReadSuratPage extends ConsumerStatefulWidget {
  const ReadSuratPage({Key? key, required this.surat}) : super(key: key);

  final Surat surat;

  @override
  ReadSuratPageState createState() => ReadSuratPageState();
}

class ReadSuratPageState extends ConsumerState<ReadSuratPage> {
  ScrollController _controller = ScrollController();
  String message = '';

  _scrollListener() {
    print(_controller.offset);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(bacaProvider(widget.surat.nomor.toString()));

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
                //     title: widget.surat.namaLatin.toString(),
                title: message,
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
                            controller: _controller,
                            slivers: [
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
