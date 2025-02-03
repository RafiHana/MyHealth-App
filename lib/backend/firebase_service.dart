import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final DatabaseReference database = FirebaseDatabase.instance.ref();
}