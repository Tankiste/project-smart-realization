import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:smart_home/firebase_services.dart';
import 'package:smart_home/model/auth/user_data.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseServices _services = FirebaseServices();

  String signature = DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> registerUser({
    required String username,
    required String email,
    required int ideal_temperature,
    required String password,
    required String confirmpassword,
  }) async {
    String resp = 'Some error occured';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          confirmpassword.isNotEmpty) {
        auth.UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserData userData = UserData(
            uid: cred.user!.uid,
            name: username,
            email: email,
            ideal_temperature: ideal_temperature,
            password: password,
            confirmpassword: confirmpassword);

        userData.house_password = password;
        userData.fingerprint = signature;

        await _services.users.doc(cred.user!.uid).set(userData.toMap());

        resp = 'success';
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  Future<String> loginUser({
    required String username,
    required String housePassword,
  }) async {
    String resp = 'Some error occured';
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('name', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        String password = userDoc['house password'];

        if (password == housePassword) {
          resp = 'success';
        } else {
          resp = 'Incorrect house password';
        }
      } else {
        resp = 'Username does not exist';
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
