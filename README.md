# PAB-MINI-PROJECT-2
## Fauzia Inanta Aurelia/ 2409116044/ Sistem Informasi (B)

## Deskripsi Aplikasi
Aplikasi Laundry Mobile adalah aplikasi berbasis Flutter untuk membantu pengelolaan data laundry secara terstuktur. Aplikasi ini membantu pengguna untuk mencatat data pelanggan, jenis layanan, berat cucian, dan total harga. Data ditampilkan dalam bentuk daftar sehingga mudah dipantau dan dikelola oleh pengguna.

## Struktur Project
lib/
 
  models/
   
    • laundry.dart
  
  pages/
    
    • home_page.dart
    
    • form_page.dart

    • login_page.dart
    
    • register_page.dart
    
 • main.dart
 
 • theme_controller.dart

 ## Fitur Aplikasi

-  Login dan Register pengguna
-  Halaman Home
-  Form input data laundry
-  Menampilkan daftar data laundry
-  Light Mode dan Dark Mode
-  Integrasi dengan Supabase
-  Penyimpanan konfigurasi menggunakan file `.env`

## Widget yang Digunakan

Beberapa widget Flutter yang digunakan dalam aplikasi ini:

- `MaterialApp`
- `Scaffold`
- `AppBar`
- `Text`
- `TextField`
- `ElevatedButton`
- `ListView`
- `Card`
- `Container`
- `Column`
- `Row`
- `Switch`
- `Form`
- `Navigator`

##  Penjelasan Nilai Tambah

### 1. Login dan Register menggunakan Supabase Auth
Aplikasi menggunakan **Supabase Authentication** untuk sistem login dan register.  
Hal ini membuat sistem lebih aman dan memanfaatkan backend cloud tanpa perlu membuat server sendiri.

---

### 2. Light Mode dan Dark Mode
Aplikasi mendukung dua tema:
-  Light Mode
-  Dark Mode

Pengguna dapat mengganti tema untuk meningkatkan kenyamanan penggunaan.

---

### 3. Menggunakan file `.env`
Aplikasi menggunakan file `.env` untuk menyimpan:

- Supabase URL
- Supabase API Key

## Teknologi yang Digunakan

- Flutter
- Dart
- Supabase
- dotenv (.env)

## Tampilan Aplikasi

1. Login Page

![image alt](https://github.com/fauziainta/PAB-MINI-PROJECT-2/blob/2f1adb0d2f7bedea87d7ae02b21e9d3b0ed2d6f0/Screenshot%202026-03-16%20130938.png)

2. Register Page

![image alt](assets/screenshots/register.png)

3. Home Page

![image alt](assets/screenshots/home.png)

4. Form Page

![image alt](assets/screenshots/form.png)

  - Terdapat dropdown pilihan Jenis Layanan

    ![image alt](assets/screenshots/form.png)

6. Dark Mode

![image alt](assets/screenshots/form.png)

