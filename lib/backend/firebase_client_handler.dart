import 'package:firebase_database/firebase_database.dart';

class FirebaseClientHandler {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  DatabaseReference get databaseRef => _databaseRef;

  Function(String)? onTemperatureUpdate;
  Function(String)? onHumidityUpdate;
  Function(String)? onCo2Update;
  Function(String)? onSmokeUpdate;
  Function(bool)? onConnectionStatus;

  FirebaseClientHandler() {
    _initialize();
  }

  void _initialize() {
    try {
      _databaseRef.child('suhu').onValue.listen((event) {
        final value = event.snapshot.value.toString();
        onTemperatureUpdate?.call(value);
      });

      _databaseRef.child('kelembapan').onValue.listen((event) {
        final value = event.snapshot.value.toString();
        onHumidityUpdate?.call(value);
      });

      _databaseRef.child('karbon_dioksida').onValue.listen((event) {
        final value = event.snapshot.value.toString();
        onCo2Update?.call(value);
      });

      _databaseRef.child('asap').onValue.listen((event) {
        final value = event.snapshot.value.toString();
        onSmokeUpdate?.call(value);
      });

      onConnectionStatus?.call(true); 
    } catch (e) {
      print('Error initializing Firebase: $e');
      onConnectionStatus?.call(false); 
    }
  }

  void disconnect() {

  }
}