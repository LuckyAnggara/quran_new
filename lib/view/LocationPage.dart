import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reverpod/constant.dart';
import 'package:reverpod/models/kota.dart';
import 'package:reverpod/provider/provider.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(daftarKotaProvider);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Kota kota = items[index];
                            return ListTile(
                              title: Text(kota.lokasi.toString()),
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
    );
  }
}
