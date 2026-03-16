import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/laundry.dart';

class FormPage extends StatefulWidget {
  final Laundry? laundry;
  const FormPage({super.key, this.laundry});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final beratController = TextEditingController();
  final totalController = TextEditingController();

  String? selectedLayanan;

  final Map<String, double> layananHarga = {
    "Cuci setrika": 8000,
    "Laundry khusus": 15000,
    "Cuci kering (tanpa setrika)": 6000,
    "Setrika saja": 6000,
    "Laundry ekspres": 12000,
  };

  Future<bool> showConfirmDialog(String title, String message) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: Text(title,
                style: const TextStyle(
                    color: Color(0xFF0C194E),
                    fontWeight: FontWeight.bold)),
            content: Text(message),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF917E65)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Tidak",
                    style: TextStyle(color: Color(0xFF917E65))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Ya"),
              ),
            ],
          ),
        ) ??
        false;
  }

  void hitungTotal() {
    double berat = double.tryParse(beratController.text) ?? 0;
    double harga = layananHarga[selectedLayanan] ?? 0;

    double total = berat * harga;

    totalController.text = total.toStringAsFixed(0);
  }

  @override
  void initState() {
    super.initState();

    if (widget.laundry != null) {
      namaController.text = widget.laundry!.nama;
      beratController.text = widget.laundry!.berat.toString();
      selectedLayanan = widget.laundry!.jenis;
      hitungTotal();
    }
  }

  InputDecoration inputStyle(String label, bool isDark) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
      filled: true,
      fillColor: isDark ? Colors.black : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFF917E65),
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFF917E65),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFF0C194E),

      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 160,
        backgroundColor: const Color(0xFFC2DEF5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(80),
          ),
        ),
        title: const Text(
          "Masukkan Data Laundry",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C194E),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: namaController,
                readOnly: widget.laundry != null,
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black),
                decoration: inputStyle("Nama Pelanggan", isDark),
                validator: (v) =>
                    v!.isEmpty ? "Nama wajib diisi" : null,
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedLayanan,
                decoration: inputStyle("Jenis Layanan", isDark),
                dropdownColor: isDark ? Colors.black : Colors.white,
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black),
                items: layananHarga.keys.map((layanan) {
                  return DropdownMenuItem(
                    value: layanan,
                    child: Text(
                        "$layanan (Rp ${layananHarga[layanan]!.toStringAsFixed(0)}/kg)"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLayanan = value;
                    hitungTotal();
                  });
                },
                validator: (v) =>
                    v == null ? "Pilih layanan" : null,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: beratController,
                keyboardType: TextInputType.number,
                onChanged: (value) => hitungTotal(),
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black),
                decoration: inputStyle("Berat (kg)", isDark),
                validator: (v) =>
                    v!.isEmpty ? "Berat wajib diisi" : null,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: totalController,
                readOnly: true,
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black),
                decoration: inputStyle("Total Harga", isDark),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 220,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDark ? Colors.white : const Color(0xFF917E65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {

                    if (!_formKey.currentState!.validate()) return;

                    bool confirm = await showConfirmDialog(
                        "Simpan Data",
                        "Yakin ingin menyimpan data?");

                    if (!confirm) return;

                    final data = Laundry(
                      id: widget.laundry?.id,
                      nama: namaController.text.trim(),
                      jenis: selectedLayanan!,
                      berat: double.parse(beratController.text),
                      harga: double.parse(totalController.text),
                      status: widget.laundry != null
                          ? widget.laundry!.status
                          : "masuk",
                    );

                    Get.back(result: data);
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}