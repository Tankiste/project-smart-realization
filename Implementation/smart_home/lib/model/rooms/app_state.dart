import 'package:flutter/material.dart';
import 'package:smart_home/firebase_services.dart';
import 'package:smart_home/model/auth/auth_service.dart';
import 'package:smart_home/model/auth/user_data.dart';

class ApplicationState extends ChangeNotifier {
  UserData? _user;
  final FirebaseServices _services = FirebaseServices();
  final AuthService _authService = AuthService();

  UserData? get getUser => _user;

  Future<void> refreshUser() async {
    try {
      UserData user = await _authService.getUserDetails();
      _user = user;
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    _user = null;
    notifyListeners();
  }
}
