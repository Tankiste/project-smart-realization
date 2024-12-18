import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/view/home.dart';
import 'package:smart_home/view/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', width: 350),
                SizedBox(
                  height: ht * 0.095,
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: ht * 0.015,
                ),
                Text(
                  'Please enter your information to get access to your home.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: ht * 0.03,
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
                  height: ht * 0.26,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFCA99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: wt * 0.34,
                            right: wt * 0.34,
                            top: ht * 0.017,
                            bottom: ht * 0.017),
                        child: Text(
                          'Login',
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
                        text: 'Not yet registered in the house ?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade500,
                        )),
                    TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBD8D73)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        RegistrationPage())));
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
