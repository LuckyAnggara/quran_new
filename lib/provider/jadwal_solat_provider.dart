import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod/models/jadwal_sholat.dart';
import 'package:reverpod/provider/provider.dart';
import 'package:reverpod/service/network_service.dart';

final jadwalSolatListProvider =
    StateNotifierProvider<JadwalSolatList, List<JadwalSholatDetail>>((ref) {
  JadwalSolatList result = JadwalSolatList();
  final data = ref.watch(jadwalProvider.future).then(
    (value) {
      result.add(1, "ashar", value.ashar!);
      result.add(2, "dzhuru", value.dzuhur!);
      result.add(3, "dzhuru", value.dzuhur!);
      result.add(4, "dzhuru", value.dzuhur!);
      result.add(5, "dzhuru", value.dzuhur!);
      result.add(6, "dzhuru", value.dzuhur!);
      result.add(7, "dzhuru", value.dzuhur!);
      result.add(8, "dzhuru", value.dzuhur!);
      result.add(9, "dzhuru", value.dzuhur!);
    },
  );

  return result;
});
