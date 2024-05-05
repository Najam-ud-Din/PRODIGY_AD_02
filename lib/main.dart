import 'dart:ui';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_do_app/Pages/Homepage.dart';
import 'package:to_do_app/Pages/addtodo.dart';
import 'package:to_do_app/Pages/signinpage.dart';
import 'package:to_do_app/Pages/signuppage.dart';
import 'package:to_do_app/Pages/splashscreen.dart';
import 'package:to_do_app/Pages/practice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyD17xI_vWcC-N3P-C2TPx4hknFZD2fWXfo',
    appId: '1:876562850199:android:4132000b59e7b8362ee4d2',
    messagingSenderId: '876562850199',
    projectId: 'todoapp-3cc79',
    authDomain: 'todoapp-3cc79.firebaseapp.com',
  ));
  runApp(
      DevicePreview(enabled: !kReleaseMode, builder: ((context) => MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage1(),
    );
    //Scaffold(
    //   appBar: AppBar(
    //     title: Text("My App"),
    //     backgroundColor: Colors.blue,
    //   ),
    //   body: SignUp(),
    //   // body: Center(
    //   //   child: ElevatedButton(
    //   //       onPressed: () {
    //   //         signup();
    //   //       },
    //   //       child: Text(
    //   //         "Sign up",
    //   //         style: TextStyle(color: Colors.blue, fontSize: 20),
    //   //       )),
    //   // ),
    // ));
  }
}
