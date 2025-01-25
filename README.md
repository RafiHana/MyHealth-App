# MyHealth App

MyHealth adalah aplikasi mobile berbasis Flutter yang membantu pengguna memantau kualitas udara lingkungan sekitar dengan menghubungkan perangkat IoT. Aplikasi ini dirancang untuk memberikan pengalaman pengguna yang intuitif dengan antarmuka yang bersih dan navigasi yang mudah.

## Fitur

- **Splash Screen**: Layar awal yang ditampilkan saat aplikasi dibuka.
- **Home Page**: Halaman utama dengan tampilan indikator udara sekitar.
- **Connection Page**: Memungkinkan pengguna untuk menghubungkan dan mengelola perangkat pemantauan IoT.
- **History Page**: Menampilkan catatan dan data selama satu minggu.
- **Custom Navigation Bar**: Navigasi bawah dengan latar belakang dinamis dan desain modern untuk akses cepat ke fitur utama.

## Teknologi yang Digunakan

- **Flutter**: Framework lintas platform untuk membangun aplikasi yang dikompilasi secara native.
- **Dart**: Bahasa pemrograman yang digunakan dengan Flutter.
- **flutter_svg**: Untuk merender aset SVG yang digunakan di navigasi bawah.

## Cara Menjalankan Aplikasi

1. **Clone Repository**:
   ```bash
   git clone https://github.com/RafiHana/esp_control.git
   ```

2. **Masuk ke Direktori Proyek**:
   ```bash
   cd esp_control
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Jalankan Aplikasi**:
   - Untuk Android:
     ```bash
     flutter run
     ```
   - Untuk iOS:
     ```bash
     flutter run --release
     ```

5. **Hubungkan Perangkat/Emulator**:
   Pastikan perangkat Android atau emulator iOS terhubung untuk melihat aplikasi berjalan.

## Aset

Aplikasi ini menggunakan ikon SVG untuk navigasi bawah. Letakkan file SVG Anda di direktori `assets/icons` dan perbarui file `pubspec.yaml` sesuai:

```yaml
flutter:
  assets:
    - assets/icons/
```

## Komponen UI Utama

- **Implementasi SafeArea**: Memastikan navigasi bawah menyesuaikan dengan berbagai ukuran layar dan konfigurasi perangkat.
- **Custom Navigation Bar**: Menampilkan gaya dinamis dan indikator pemilihan.

## Pemecahan Masalah

- Jika Anda mengalami kesalahan `RenderFlex overflowed`, pastikan widget `SafeArea` digunakan dengan benar dalam `Scaffold`.
- Selalu periksa bahwa aset SVG terhubung dengan benar di `pubspec.yaml`.

## Kontributor

- Rafi Hana - Developer

---

Silakan modifikasi atau kembangkan proyek ini!

