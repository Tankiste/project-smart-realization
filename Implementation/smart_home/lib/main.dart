import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/firebase_options.dart';
// import 'package:smart_home/model/devices/device_services.dart';
import 'package:smart_home/model/rooms/app_state.dart';
import 'package:smart_home/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await updateDevicesWithRoomInfo();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ApplicationState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Your initial screen
    );
  }
}
