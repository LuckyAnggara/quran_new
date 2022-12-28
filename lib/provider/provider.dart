import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod/models/kota.dart';

import '../models/detail_surat.dart';
import '../models/surat.dart';
import '../service/network_service.dart';

final suratProvider = FutureProvider<List<Surat>>((ref) async {
  return ref.read(apiQuranProvider).getSurat();
});

final bacaProvider = FutureProvider.family<DetailSurat, String>(
  (ref, id) async {
    return ref.read(apiQuranProvider).getDetailSurat(id);
  },
);

final daftarKotaProvider = FutureProvider.autoDispose<List<Kota>>((ref) async {
  return ref.read(apiShalatProvider).getKota();
});
