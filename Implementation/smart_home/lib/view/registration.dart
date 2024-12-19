import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/model/auth/auth_service.dart';
import 'package:smart_home/model/biometric_service.dart';
import 'package:smart_home/view/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final LocalAuthenticationService _authService = LocalAuthenticationService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tempController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscurePassword2 = true;
  bool isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscurePassword2 = !_obscurePassword2;
    });
  }

  Future<void> _authenticate() async {
    bool isSupported = await _authService.isBiometricSupported();
    if (!isSupported) {
      _showErrorDialog('Your device doesn\'t offers biometric authentication.');
      return;
    }

    bool canCheckBiometrics = await _authService.canCheckBiometrics();
    if (!canCheckBiometrics) {
      _showErrorDialog('No biometric value registered.');
      return;
    }

    bool authenticated = await _authService.authenticate();
    if (authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fingerprint successfully registered')));
      Navigator.of(context).pop();
    } else {
      _showErrorDialog('Authentication failed.');
    }
  }

  // Future<void> _registerFingerprint() async {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(
  //             'Fingerprint Registration',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           content: GestureDetector(
  //             onTap: () => _performBiometricRegistration(),
  //             child: Image.asset(
  //               'assets/images/fingerprint.png',
  //               width: 150,
  //             ),
  //           ),
  //         );
  //       });
  // }

  // Future<void> _performBiometricRegistration() async {
  //   try {
  //     final fingerprint = await Fingerprint.create();

  //     if (fingerprint != null) {
  //       print(fingerprint);
  //       // print('Canonical form : ${fingerprint.toCanonicalString()}');
  //     } else {
  //       _showErrorDialog('Fingerprint signature generation is impoosible!');
  //     }
  //   } catch (e) {
  //     _showErrorDialog('Error during fingerprint generation : ${e.toString()}');
  //   }
  // }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpassController.dispose();
    _tempController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void registerMember() async {
    if (_registerFormKey.currentState!.validate()) {
      await _authenticate();
      setState(() {
        isLoading = true;
      });
      String resp = await AuthService().registerUser(
          username: _nameController.text,
          email: _emailController.text,
          ideal_temperature: int.parse(_tempController.text),
          password: _passwordController.text,
          confirmpassword: _confirmpassController.text);
      if (resp == 'success') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFF8EC),
      body: Center(
        child: Container(
          width: wt,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', width: 350),
                SizedBox(
                  height: ht * 0.07,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: ht * 0.015,
                ),
                Text(
                  'Please fill the following fields to register in the house.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: ht * 0.015,
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
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: _tempController,
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
                  height: ht * 0.02,
                ),
                Text('Email',
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter your mail',
                          // contentPadding:
                          //     EdgeInsets.only(left: 10, top: 5),
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: ht * 0.02,
                ),
                Text('House Password',
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
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: _togglePasswordVisibility),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: ht * 0.02,
                ),
                Text('Confirm Password',
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
                      controller: _confirmpassController,
                      obscureText: _obscurePassword2,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: _togglePasswordVisibility2),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: ht * 0.05,
                ),
                ElevatedButton(
                    onPressed: () {
                      isLoading ? null : registerMember();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFCA99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: wt * 0.31,
                            right: wt * 0.31,
                            top: ht * 0.017,
                            bottom: ht * 0.017),
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white))
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ))),
                SizedBox(
                  height: ht * 0.01,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Already a member of the house ?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade500,
                        )),
                    TextSpan(
                        text: ' Login',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBD8D73)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginPage())));
                          })
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
