import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String uid;
  String name;
  int ideal_temperature;
  String? fingerprint;
  String? email;
  String? password;
  String? confirmpassword;
  String? house_password;

  UserData(
      {required this.uid,
      required this.name,
      required this.ideal_temperature,
      this.fingerprint,
      this.email,
      this.password,
      this.confirmpassword,
      this.house_password});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': name,
      'email': email,
      'fingerprint': fingerprint,
      'ideal temp.': ideal_temperature,
      'home password': password,
    };
  }

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
      uid: snapshot['uid'],
      name: snapshot['username'],
      email: snapshot['email'],
      fingerprint: snapshot['fingerprint'],
      ideal_temperature: snapshot['ideal temp.'],
      house_password: snapshot['house password'],
    );
  }
}
