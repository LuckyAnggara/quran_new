import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/detail_surat.dart';
import '../models/surat.dart';
import '../service/network_service.dart';

final suratProvider = FutureProvider<List<Surat>>((ref) async {
  return ref.read(apiQuranProvider).getSurat();
});

final bacaProvider = FutureProvider.family.autoDispose<DetailSurat, String>(
  (ref, id) async {
    return ref.read(apiQuranProvider).getDetailSurat(id);
  },
);
