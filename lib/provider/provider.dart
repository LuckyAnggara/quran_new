import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpod/models/jadwal_sholat.dart';
import 'package:reverpod/models/kota.dart';
import 'package:reverpod/models/setting.dart';
import 'package:reverpod/provider/setting_provider.dart';

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

final searchKotaProvider = StateProvider<String>((ref) {
  return '';
});

final daftarKotaProvider = FutureProvider<List<Kota>>((ref) async {
  final String response = await rootBundle.loadString('assets/kota.json');
  final List result = jsonDecode(response);
  final key = ref.watch(searchKotaProvider);

  var data = result.map(
    ((e) => Kota.fromJson(e)),
  );
  if (key == '') {
    return data.toList();
  }

  return data
      .where((element) => element.lokasi!.contains(key.toUpperCase()))
      .toList();
});

final namaKotaProvider = FutureProvider<Kota>((ref) async {
  final String response = await rootBundle.loadString('assets/kota.json');
  final List result = jsonDecode(response);

  final id = ref.watch(settingNotifierProvider).setting.getString('lokasiId');

  var data = result.map(((e) => Kota.fromJson(e))).toList();
  return data.where((element) => element.id == id.toString()).first;
});

final jadwalProvider = FutureProvider<Jadwal>((ref) async {
  final locationId =
      ref.watch(settingNotifierProvider).setting.getString('lokasiId');
  return ref.read(apiShalatProvider).getJadwal(locationId);
});
