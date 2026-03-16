import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/laundry.dart';
import 'form_page.dart';
import 'login_page.dart';
import '../theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  final themeController = Get.find<ThemeController>();

  List<Laundry> dataLaundry = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLaundry();
  }

  Future<void> fetchLaundry() async {
    final response = await supabase.from('laundry').select();
    setState(() {
      dataLaundry =
          (response as List).map((e) => Laundry.fromMap(e)).toList();
      isLoading = false;
    });
  }

  Future<void> tambahData(Laundry laundry) async {
    await supabase.from('laundry').insert(laundry.toMap());
    fetchLaundry();
  }

  Future<void> editData(Laundry laundry) async {
    await supabase
        .from('laundry')
        .update(laundry.toMap())
        .eq('id', laundry.id!);
    fetchLaundry();
  }

  Future<void> hapusData(int id) async {
    await supabase.from('laundry').delete().eq('id', id);
    fetchLaundry();
  }

  Future<void> logout() async {
    bool confirm = await confirmLogout();
    if (!confirm) return;
    await supabase.auth.signOut();
    Get.offAll(const LoginPage());
  }

  Future<bool> confirmLogout() async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: const Text("Logout",
                style: TextStyle(
                    color: Color(0xFF0C194E),
                    fontWeight: FontWeight.bold)),
            content: const Text("Yakin ingin keluar dari akun?"),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF917E65)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Tidak",
                    style: TextStyle(color: Color(0xFF917E65))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Ya"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> confirmEdit() async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: const Text("Edit Data",
                style: TextStyle(
                    color: Color(0xFF0C194E),
                    fontWeight: FontWeight.bold)),
            content: const Text("Yakin ingin mengedit data?"),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF917E65)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Tidak",
                    style: TextStyle(color: Color(0xFF917E65))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Ya"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> confirmHapus() async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: const Text("Hapus Data",
                style: TextStyle(
                    color: Color(0xFF0C194E),
                    fontWeight: FontWeight.bold)),
            content: const Text("Data akan dihapus permanen"),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF917E65)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Tidak",
                    style: TextStyle(color: Color(0xFF917E65))),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Ya"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'masuk':
        return Colors.grey;
      case 'proses':
        return Colors.orange;
      case 'selesai':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  Widget buildLaundryCard(Laundry item, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF917E65), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style:
                  TextStyle(color: isDark ? Colors.white : Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.nama,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 25)),
                  Text('${item.jenis} | ${item.berat} kg'),
                  Text('Total: Rp ${item.harga}'),
                  Text('Status: ${item.status}',
                      style: TextStyle(
                          color: getStatusColor(item.status),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              PopupMenuButton<String>(
                icon: Icon(Icons.sync,
                    color: isDark ? Colors.white : Colors.green),
                onSelected: (value) async {
                  await supabase
                      .from('laundry')
                      .update({'status': value})
                      .eq('id', item.id!);
                  fetchLaundry();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'masuk', child: Text('Masuk')),
                  PopupMenuItem(value: 'proses', child: Text('Proses')),
                  PopupMenuItem(value: 'selesai', child: Text('Selesai')),
                ],
              ),
              IconButton(
                icon: Icon(Icons.edit,
                    color: isDark ? Colors.white : Colors.blue),
                onPressed: () async {
                  bool confirm = await confirmEdit();
                  if (!confirm) return;
                  final result =
                      await Get.to(() => FormPage(laundry: item));
                  if (result != null) await editData(result);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete,
                    color: isDark ? Colors.white : Colors.red),
                onPressed: () async {
                  bool confirm = await confirmHapus();
                  if (confirm) hapusData(item.id!);
                },
              ),
            ],
          )
        ],
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
        ),
        title: Text(
          'Clairé Laundry',
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.black : const Color(0xFF0C194E),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => themeController.toggleTheme(),
          ),
          IconButton(
            icon:
                Icon(Icons.logout, color: isDark ? Colors.white : Colors.black),
            onPressed: logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF917E65),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Tambah Data',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final result =
                          await Get.to(() => const FormPage());
                      if (result != null) await tambahData(result);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataLaundry.length,
                    itemBuilder: (context, index) {
                      return buildLaundryCard(
                          dataLaundry[index], isDark);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}