import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AddUserForm extends StatefulWidget {
  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  GlobalKey<FormState> _addUserFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to add user',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Error during authentication: $e');
    }

    if (authenticated) {
      print(
          'User added with username: ${_usernameController.text} and ideal temperature: ${_temperatureController.text}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User Added Successfully')));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Authentication failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text('Add a New User',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)),
      // height: ht * 0.6,
      // width: wt * 0.8,
      content: Form(
        key: _addUserFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ht * 0.02,
            ),
            Text('Username',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF858585))),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: ht * 0.055,
                padding: EdgeInsets.only(left: 10, bottom: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    )),
                child: TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      // contentPadding:
                      //     EdgeInsets.only(left: 10, top: 5),
                      hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: ht * 0.02,
            ),
            Text('Ideal home temperature',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF858585))),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: ht * 0.055,
                padding: EdgeInsets.only(left: 10, bottom: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    )),
                child: TextFormField(
                  controller: _temperatureController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      suffixText: '°C',
                      suffixStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                      hintText: 'Enter your ideal temperature',
                      // contentPadding:
                      //     EdgeInsets.only(left: 10, top: 5),

                      hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                      border: InputBorder.none),
                  validator: (value) {
                    final temp = double.tryParse(value ?? '');
                    if (temp == null || temp < 16.0 || temp > 32.0) {
                      return 'Please enter a temperature between 16 and 32';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: ht * 0.03,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 15)),
            ),
            ElevatedButton(
                onPressed: () => _authenticate(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFCA99),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: wt * 0.07,
                        right: wt * 0.07,
                        top: ht * 0.012,
                        bottom: ht * 0.012),
                    child: Text(
                      'Add User',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ))),
          ],
        ),
      ],
    );
  }
}
