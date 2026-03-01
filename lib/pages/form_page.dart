import 'package:flutter/material.dart';
import '../models/laundry.dart';
import 'package:get/get.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController beratController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  void simpanData() {
  if (_formKey.currentState!.validate()) {
    final laundry = Laundry(
      nama: namaController.text,
      berat: double.parse(beratController.text),
      jenis: jenisController.text,
      harga: double.parse(hargaController.text),
    );

    Get.back(result: laundry);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 25, 78),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 140,
        backgroundColor: const Color.fromARGB(255, 194, 222, 245),
        elevation: 4,
        shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(100),   
        
          ),
        ), 
        title: const Text(
          'Data Pesanan',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 25, 78),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildInputField(
                  controller: namaController,
                  label: 'Nama Pelanggan',
                ),
                buildInputField(
                  controller: beratController,
                  label: 'Berat Cucian (Kg)',
                  isNumber: true,
                ),
                buildInputField(
                  controller: jenisController,
                  label: 'Jenis Layanan',
                ),
                buildInputField(
                  controller: hargaController,
                  label: 'Harga (/Kg)',
                  isNumber: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: simpanData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 145, 126, 101),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 19,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 8,
                  ),
                 
               child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    bool isNumber = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 145, 126, 101),
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 12, 25, 78),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}