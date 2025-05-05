// lib/data/model/order.dart

class Order {
  final int? idUser;
  final int idLaundry;
  final String tanggalPesanan;
  final String status;
  final String totalHarga;
  final String jenisPembayaran;
  final String tglLanggananBerakhir;
  final String alamat;
  final String waktuAmbil;
  final String catatan;
  final bool antarSendiri;
  final String nomorHp;
  final String namaLaundry;

  Order({
    required this.idUser,
    required this.idLaundry,
    required this.tanggalPesanan,
    required this.status,
    required this.totalHarga,
    required this.jenisPembayaran,
    required this.tglLanggananBerakhir,
    required this.alamat,
    required this.waktuAmbil,
    required this.catatan,
    required this.antarSendiri,
    required this.nomorHp,
    required this.namaLaundry,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'id_laundry': idLaundry,
      'tanggal_pesanan': tanggalPesanan,
      'status': status,
      'total_harga': totalHarga,
      'jenis_pembayaran': jenisPembayaran,
      'tgl_langganan_berakhir': tglLanggananBerakhir,
      'alamat': alamat,
      'waktu_ambil': waktuAmbil,
      'catatan': catatan,
      'antar_sendiri': antarSendiri, // This will be converted to 0/1 in the API service
      'nomor_hp': nomorHp,
      'nama_laundry': namaLaundry,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idUser: json['id_user'],
      idLaundry: json['id_laundry'],
      tanggalPesanan: json['tanggal_pesanan'],
      status: json['status'],
      totalHarga: json['total_harga'].toString(),
      jenisPembayaran: json['jenis_pembayaran'],
      tglLanggananBerakhir: json['tgl_langganan_berakhir'],
      alamat: json['alamat'],
      waktuAmbil: json['waktu_ambil'],
      catatan: json['catatan'] ?? '',
      antarSendiri: json['antar_sendiri'] == 1 || json['antar_sendiri'] == true,
      nomorHp: json['nomor_hp'],
      namaLaundry: json['nama_laundry'] ?? '',
    );
  }
}