// lib/data/model/order.dart

class Order {
  int? idUser;
  final int idLaundry;
  final String tanggalPesanan;
  final String status;
  final String totalHarga;
  String? jenisPembayaran;
  String? tglLanggananBerakhir;
  final String alamat;
  final String waktuAmbil;
  final String catatan;
  final String pengiriman;
  final String nomorHp;
  final String namaLaundry;

  Order({
    required this.idUser,
    required this.idLaundry,
    required this.tanggalPesanan,
    required this.status,
    required this.totalHarga,
    this.jenisPembayaran,
    this.tglLanggananBerakhir,
    required this.alamat,
    required this.waktuAmbil,
    required this.catatan,
    required this.pengiriman,
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
      'pengiriman': pengiriman,
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
      pengiriman: json['pengiriman'],
      nomorHp: json['nomor_hp'],
      namaLaundry: json['nama_laundry'] ?? '',
    );
  }
}
