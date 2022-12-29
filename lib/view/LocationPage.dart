import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/models/kota.dart';
import 'package:reverpod/models/setting.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:go_router/go_router.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(daftarKotaProvider);
    final dataKota = ref.watch(namaKotaProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Lokasi',
          style: kPrimaryFontStyle,
        ),
      ),
      body: Container(
        color: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Lokasi saat ini',
                    style: kPrimaryFontStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  dataKota.when(
                    data: (kota) {
                      return Text(kota.lokasi!,
                          style: kSecondaryFontStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500));
                    },
                    error: (err, stk) {
                      return Center(
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
                      );
                    },
                    loading: () => Center(
                      child: SpinKitWave(
                        color: kSecondaryColor,
                        size: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (newValue) {
                        ref.read(searchKotaProvider.notifier).state = newValue;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kSecondaryColor),
                        ),
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: kSecondaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: kSecondaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: data.when(
                        data: (items) {
                          return items.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Tidak ada data',
                                        style: kPrimaryFontStyle.copyWith(
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                )
                              : CustomScrollView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          Kota kota = items[index];
                                          return GestureDetector(
                                            onTap: () {
                                              showGeneralDialog(
                                                barrierLabel: "Label",
                                                barrierDismissible: true,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                transitionDuration:
                                                    Duration(milliseconds: 400),
                                                context: context,
                                                pageBuilder:
                                                    (context, anim1, anim2) {
                                                  return CustomDialogBox(
                                                    kota: kota,
                                                  );
                                                },
                                                transitionBuilder: (context,
                                                    anim1, anim2, child) {
                                                  return SlideTransition(
                                                    position: Tween(
                                                            begin: Offset(0, 1),
                                                            end: Offset(0, 0))
                                                        .animate(anim1),
                                                    child: child,
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                ),
                                                child: Text(
                                                    kota.lokasi.toString())),
                                          );
                                        },
                                        childCount: items.length,
                                      ),
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
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialogBox extends ConsumerWidget {
  final Kota? kota;

  const CustomDialogBox({
    super.key,
    required this.kota,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDialogpadding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, ref),
    );
  }

  contentBox(context, ref) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: kDialogpadding,
            top: kDialogavatarRadius + kDialogpadding,
            right: kDialogpadding,
            bottom: kDialogpadding,
          ),
          margin: EdgeInsets.only(top: kDialogavatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(kDialogpadding),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 2), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Ubah lokasi ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Lokasi akan di ubah ke',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${kota!.lokasi}',
                style: kPrimaryFontStyle.copyWith(
                    fontSize: 16, color: kSecondaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    ref
                        .read(settingNotifierProvider.notifier)
                        .updateKeyString('lokasiId', '${kota!.id}');
                    GoRouter.of(context).pop();
                  },
                  child: const Text(
                    'Ya',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: kDialogpadding,
          right: kDialogpadding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: kDialogavatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(kDialogavatarRadius)),
                child: Image.asset("assets/icons/compas.png")),
          ),
        ),
      ],
    );
  }
}
