import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reverpod/models/jadwal_sholat.dart';
import 'package:reverpod/models/kota.dart';
import 'package:reverpod/models/now_playing.dart';
import 'package:reverpod/models/setting.dart';
import 'package:flutter/material.dart';

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

final nowPlayingProvider = StateProvider<NowPlaying>((ref) {
  return NowPlaying();
});

final justAudioProvider = FutureProvider<AudioPlayer>((ref) {
  final AudioPlayer audioPlayer = AudioPlayer();
  final nowPlaying = ref.watch(nowPlayingProvider);
  audioPlayer.setUrl(nowPlaying.getUrl);
  return audioPlayer;
});

final settingProvider = StateProvider<Setting>((ref) => Setting());

class SettingNotifier extends ChangeNotifier {
  final setting = Setting();

  void updateKeyBool(String keyValue, value) {
    setting.setBool(keyValue, value);
    notifyListeners();
  }

  void updateKeyString(String keyValue, value) {
    setting.setString(keyValue, value);
    notifyListeners();
  }

  void updateKeyDouble(String keyValue, value) {
    setting.setDouble(keyValue, value);
    notifyListeners();
  }
}

final settingNotifierProvider = ChangeNotifierProvider<SettingNotifier>((ref) {
  return SettingNotifier();
});

final alarmSholatProvider = StateProvider<bool>((ref) {
  return false;
});
