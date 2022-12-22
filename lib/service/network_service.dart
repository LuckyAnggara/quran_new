import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:reverpod/constant.dart';
import 'package:reverpod/models/detail_surat.dart';
import 'package:reverpod/models/jadwal_sholat.dart';
import 'package:reverpod/models/surat.dart';

import '../models/kota.dart';

class NetworkService {
  Future<List<Surat>> getSurat() async {
    var url = Uri.parse('${ApiConstants.quranUrl}/surat');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      final List result = jsonDecode(res.body);
      return result.map(((e) => Surat.fromJson(e))).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  Future<DetailSurat> getDetailSurat(String nomor) async {
    var url = Uri.parse('${ApiConstants.quranUrl}/surat/${nomor}');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return DetailSurat.fromJson(data);
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}

class PrayTimeServices {
  Future<List<Kota>?> getKota() async {
    var url = Uri.parse('${ApiConstants.prayTimeUrl}/sholat/kota/semua');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      final List result = jsonDecode(res.body);
      return result.map(((e) => Kota.fromJson(e))).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  Future<Jadwal> getJadwal(String locationId) async {
    var url = Uri.parse(
        '${ApiConstants.prayTimeUrl}/sholat/jadwal/$locationId/2022/05/22');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return Jadwal.fromJson(data['data']['jadwal']);
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}

// API SERVICE PROVIDER
final apiQuranProvider = Provider<NetworkService>((ref) => NetworkService());
final apiShalatProvider =
    Provider<PrayTimeServices>((ref) => PrayTimeServices());
