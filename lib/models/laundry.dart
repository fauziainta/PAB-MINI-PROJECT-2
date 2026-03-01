class Laundry {
  String nama;
  double berat;
  String jenis;
  double harga;
  bool isSelesai;

  Laundry({
    required this.nama,
    required this.berat,
    required this.jenis,
    required this.harga,
    this.isSelesai = false,
  });

  double get total => berat * harga;
}