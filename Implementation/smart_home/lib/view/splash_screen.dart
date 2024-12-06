import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    // var wh = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: ht * 0.1),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/smart_on_table.jpg"),
                fit: BoxFit.cover,
                opacity: 0.8,
                alignment: Alignment(-0.4, 0.0))),
        child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/logo.png",
              width: 350,
            )),
      ),
    );
  }
}
