// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  CollectionReference devices =
      FirebaseFirestore.instance.collection('devices');

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
}
