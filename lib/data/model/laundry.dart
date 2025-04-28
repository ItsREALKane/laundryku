class Laundry {
  final int id;
  final String nama;
  final String alamat;
  final String nomor;
  final String img;
  final double rating;
  final String jasa;
  final String pengantaran;

  Laundry({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.nomor,
    required this.img,
    required this.rating,
    required this.jasa,
    required this.pengantaran,
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
      pengantaran: json['pengantaran'],
    );
  }

  List<String> getCategories() {
    final jasaList =
        jasa.toLowerCase().split(',').map((e) => e.trim()).toList();
    return jasaList;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'nomor': nomor,
      'img': img,
      'rating': rating,
      'jasa': jasa,
      'pengantaran': pengantaran,
    };
  }
}
