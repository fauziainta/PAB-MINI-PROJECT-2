import 'package:flutter/material.dart';
import '../models/laundry.dart';
import 'form_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Laundry> dataLaundry = [];

  void tambahData(Laundry laundry) {
    setState(() {
      dataLaundry.add(laundry);
    });
  }

  void hapusData(int index) {
    setState(() {
      dataLaundry.removeAt(index);
    });
  }

  void updateStatus(int index) {
    setState(() {
      dataLaundry[index].isSelesai = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 25, 78)  ,
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
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 240, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 12, 25, 78),
            borderRadius: BorderRadius.circular(60),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 12, 25, 78),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            ' Clairé Laundry˖',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),

        if (dataLaundry.isEmpty)
          const Text(
            'Belum ada data',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataLaundry.length,
            itemBuilder: (context, index) {
              final item = dataLaundry[index];
              return Card(
                margin: const EdgeInsets.all(12),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 145, 126, 101),
                    width: 2,
                  ),
                ),
                child: ListTile(
                  

                  title: Text(
                    item.nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.jenis} | ${item.berat} kg'),
                      Text('Total: Rp ${item.total}'),
                      Text(
                        item.isSelesai
                            ? 'Status: Selesai'
                            : 'Status: Proses',
                        style: TextStyle(
                          color: item.isSelesai
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!item.isSelesai)
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => updateStatus(index),
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => hapusData(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        const SizedBox(height: 20),

        Center(
          child: GestureDetector(
            onTap: () async {
              final result = await Get.to(() => const FormPage());
              
              if (result != null && result is Laundry) {
                  tambahData(result);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 145, 126, 101),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Tambah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    ),
  ),
),
    );
  }
}