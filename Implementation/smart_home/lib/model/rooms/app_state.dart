import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:smart_home/firebase_services.dart';
import 'package:smart_home/model/auth/auth_service.dart';
import 'package:smart_home/model/auth/user_data.dart';

class ApplicationState extends ChangeNotifier {
  UserData? _user;
  // final FirebaseServices _services = FirebaseServices();
  final AuthService _authService = AuthService();
  List<UserData> _users = [];

  UserData? get getUser => _user;
  List<UserData> get getUsers => _users;

  Future<void> refreshUser() async {
    try {
      print('Starting refreshUser');
      UserData user = await _authService.getUserDetails();
      _user = user;
      print('User refreshed successfully: ${user.name}');
      notifyListeners();
    } catch (error) {
      print('Error in refreshUser: $error');
      _user = null;
      notifyListeners();
    }
  }

  Future<void> fetchUsers() async {
    try {
      List<DocumentSnapshot> userDocs = await _authService.getUsers();
      _users = userDocs.map((doc) => UserData.fromSnap(doc)).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  Future<void> addUser(String username, int idealTemperature) async {
    String response = await _authService.addUser(
        username: username, idealTemp: idealTemperature);
    if (response == 'success') {
      await fetchUsers();
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    _user = null;
    notifyListeners();
  }
}
