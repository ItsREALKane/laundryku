class Order {
  final int id;
  final int idUser;
  final int idLaundry;
  final DateTime tanggalPesanan;
  final String status;
  final String totalHarga;
  final String jenisPembayaran;
  final DateTime tglLanggananBerakhir;
  final String alamat;
  final String waktuAmbil;
  final String catatan;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.parse(json['id'].toString()),
      idUser: int.parse(json['id_user'].toString()),
      idLaundry: int.parse(json['id_laundry'].toString()),
      tanggalPesanan: DateTime.parse(json['tanggal_pesanan']),
      status: json['status'],
      totalHarga: json['total_harga'],
      jenisPembayaran: json['jenis_pembayaran'],
      tglLanggananBerakhir: DateTime.parse(json['tgl_langganan_berakhir']),
      alamat: json['alamat'],
      waktuAmbil: json['waktu_ambil'],
      catatan: json['catatan'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'id_laundry': idLaundry,
      'tanggal_pesanan': tanggalPesanan.toIso8601String(),
      'status': status,
      'total_harga': totalHarga,
      'jenis_pembayaran': jenisPembayaran,
      'tgl_langganan_berakhir': tglLanggananBerakhir.toIso8601String(),
      'alamat': alamat,
      'waktu_ambil': waktuAmbil,
      'catatan': catatan,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
