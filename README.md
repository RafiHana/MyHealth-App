# MyHealth App

MyHealth adalah aplikasi mobile berbasis Flutter yang membantu pengguna memantau kualitas udara di lingkungan sekitar menggunakan perangkat IoT (ESP32 + Sensor). Aplikasi ini menggunakan MQTT untuk menerima data suhu, kelembapan, karbon dioksida (CO₂), dan asap secara real-time dari Firebase Realtime Database sebagai broker MQTT.

##
🚀 Fitur

- **📊 Monitoring Real-time**: Data dari ESP32 diperbarui langsung di aplikasi.
- **📡 MQTT dengan Firebase**: Menggunakan Firebase Realtime Database sebagai broker MQTT.
- **🏠 Home Page**: Menampilkan kondisi udara saat ini secara visual dan informatif.
- **🔗 Connection Page**: Memungkinkan pengguna menghubungkan perangkat IoT.
- **📜 History Page**: Menampilkan riwayat data selama satu minggu.
- **📍 Custom Navigation Bar**: Navigasi modern untuk pengalaman pengguna yang lebih baik.

##
🛠 Teknologi yang Digunakan

- **Flutter**: Framework utama untuk membangun aplikasi mobile.
- **Dart**: Bahasa pemrograman yang digunakan dalam Flutter.
- **Firebase Realtime Database**: Sebagai broker MQTT untuk komunikasi dengan ESP32.
- **MQTT (mqtt_client)**: Protokol komunikasi yang digunakan untuk menerima data sensor.
- **flutter_svg**: Untuk menampilkan ikon SVG di aplikasi.

##
📌 Cara Menjalankan Aplikasi

1. **Clone Repository**:
   ```bash
   git clone https://github.com/RafiHana/MyHealth-App.git
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

#
🤝 Kontributor

- Rafi Hana - Developer

---

Silakan modifikasi atau kembangkan proyek ini!

