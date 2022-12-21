class Tafsir {
  bool? status;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  List<Tafsir>? tafsir;
  SuratSelanjutnya? suratSelanjutnya;
  bool? suratSebelumnya;

  Tafsir(
      {this.status,
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio,
      this.tafsir,
      this.suratSelanjutnya,
      this.suratSebelumnya});

  Tafsir.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
    if (json['tafsir'] != null) {
      tafsir = <Tafsir>[];
      json['tafsir'].forEach((v) {
        tafsir!.add(new Tafsir.fromJson(v));
      });
    }
    suratSelanjutnya = json['surat_selanjutnya'] != null
        ? new SuratSelanjutnya.fromJson(json['surat_selanjutnya'])
        : null;
    suratSebelumnya = json['surat_sebelumnya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    data['nama_latin'] = this.namaLatin;
    data['jumlah_ayat'] = this.jumlahAyat;
    data['tempat_turun'] = this.tempatTurun;
    data['arti'] = this.arti;
    data['deskripsi'] = this.deskripsi;
    data['audio'] = this.audio;
    if (this.tafsir != null) {
      data['tafsir'] = this.tafsir!.map((v) => v.toJson()).toList();
    }
    if (this.suratSelanjutnya != null) {
      data['surat_selanjutnya'] = this.suratSelanjutnya!.toJson();
    }
    data['surat_sebelumnya'] = this.suratSebelumnya;
    return data;
  }
}

class ListTafsir {
  int? id;
  int? surah;
  int? ayat;
  String? tafsir;

  ListTafsir({this.id, this.surah, this.ayat, this.tafsir});

  ListTafsir.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    ayat = json['ayat'];
    tafsir = json['tafsir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surah'] = this.surah;
    data['ayat'] = this.ayat;
    data['tafsir'] = this.tafsir;
    return data;
  }
}

class SuratSelanjutnya {
  int? id;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  SuratSelanjutnya(
      {this.id,
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio});

  SuratSelanjutnya.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['nama_latin'];
    jumlahAyat = json['jumlah_ayat'];
    tempatTurun = json['tempat_turun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomor'] = this.nomor;
    data['nama'] = this.nama;
    data['nama_latin'] = this.namaLatin;
    data['jumlah_ayat'] = this.jumlahAyat;
    data['tempat_turun'] = this.tempatTurun;
    data['arti'] = this.arti;
    data['deskripsi'] = this.deskripsi;
    data['audio'] = this.audio;
    return data;
  }
}
