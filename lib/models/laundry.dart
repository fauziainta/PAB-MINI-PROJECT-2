class Laundry {
  int? id;
  String nama;
  double berat;
  String jenis;
  double harga;
  String status;

  Laundry({
    this.id,
    required this.nama,
    required this.berat,
    required this.jenis,
    required this.harga,
    this.status = 'masuk',
  });

  double get total => berat * harga;

  factory Laundry.fromMap(Map data) {
    return Laundry(
      id: data['id'],
      nama: data['nama'],
      berat: (data['berat'] as num).toDouble(),
      jenis: data['jenis'],
      harga: (data['harga'] as num).toDouble(),
      status: data['status'] ?? 'masuk',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'berat': berat,
      'jenis': jenis,
      'harga': harga,
      'status': status,
    };
  }
}