import 'package:riverpod/riverpod.dart';

class JadwalSholat {
  String? id;
  String? lokasi;
  String? daerah;
  Koordinat? koordinat;
  Jadwal? jadwal;

  JadwalSholat(
      {this.id, this.lokasi, this.daerah, this.koordinat, this.jadwal});

  JadwalSholat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
    daerah = json['daerah'];
    koordinat = json['koordinat'] != null
        ? new Koordinat.fromJson(json['koordinat'])
        : null;
    jadwal =
        json['jadwal'] != null ? new Jadwal.fromJson(json['jadwal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lokasi'] = this.lokasi;
    data['daerah'] = this.daerah;
    if (this.koordinat != null) {
      data['koordinat'] = this.koordinat!.toJson();
    }
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal!.toJson();
    }
    return data;
  }
}

class Koordinat {
  double? lat;
  double? lon;
  String? lintang;
  String? bujur;

  Koordinat({this.lat, this.lon, this.lintang, this.bujur});

  Koordinat.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    lintang = json['lintang'];
    bujur = json['bujur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['lintang'] = this.lintang;
    data['bujur'] = this.bujur;
    return data;
  }
}

class Jadwal {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;
  String? date;

  Jadwal(
      {this.tanggal,
      this.imsak,
      this.subuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.isya,
      this.date});

  Jadwal.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsak = json['imsak'];
    subuh = json['subuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashar = json['ashar'];
    maghrib = json['maghrib'];
    isya = json['isya'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['imsak'] = this.imsak;
    data['subuh'] = this.subuh;
    data['terbit'] = this.terbit;
    data['dhuha'] = this.dhuha;
    data['dzuhur'] = this.dzuhur;
    data['ashar'] = this.ashar;
    data['maghrib'] = this.maghrib;
    data['isya'] = this.isya;
    data['date'] = this.date;
    return data;
  }
}

class JadwalSholatDetail {
  final String name;
  final String time;
  final int id;
  bool isDone;
  bool isAlarm;
  JadwalSholatDetail(
      {required this.id,
      required this.name,
      required this.time,
      this.isDone = false,
      this.isAlarm = false});
}

class JadwalSolatList extends StateNotifier<List<JadwalSholatDetail>> {
  JadwalSolatList([List<JadwalSholatDetail>? initialJadwalSolatList])
      : super(initialJadwalSolatList ?? []);

  void add(int id, String name, String time) {
    state = [
      ...state,
      JadwalSholatDetail(id: id, name: name, time: time),
    ];
  }

  void toggleAlarm(int id) {
    state = [
      for (final jadwal in state)
        if (jadwal.id == id)
          JadwalSholatDetail(
            id: jadwal.id,
            isAlarm: !jadwal.isAlarm,
            name: jadwal.name,
            time: jadwal.time,
          )
        else
          jadwal,
    ];
  }

  void toggleDone(String id) {
    state = [
      for (final jadwal in state)
        if (jadwal.id == id)
          JadwalSholatDetail(
            id: jadwal.id,
            isDone: !jadwal.isDone,
            name: jadwal.name,
            time: jadwal.time,
          )
        else
          jadwal,
    ];
  }
}
