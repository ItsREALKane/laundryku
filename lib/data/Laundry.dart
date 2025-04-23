class Laundry {
  final int id;
  final String nama;
  final String alamat;
  final String nomor;
  final String img;
  final double rating;
  final String jasa;

  Laundry({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.nomor,
    required this.img,
    required this.rating,
    required this.jasa,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      id: int.parse(json['id'].toString()),
      nama: json['nama'],
      alamat: json['alamat'],
      nomor: json['nomor'],
      img: json['img'],
      rating: double.parse(json['rating'].toString()),
      jasa: json['jasa'],
    );
  }
}
