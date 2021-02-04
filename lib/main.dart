import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          dialogBackgroundColor: Colors.black,
          primarySwatch: Colors.grey,
          cardColor: Colors.white70,
          accentColor: Colors.black,
        ),
        home: HomePage()
        // Scaffold(
        //   appBar: AppBar(
        //     centerTitle: true,
        //     title: Text(
        //       'Welcome to preCodes',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 20.0,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        //   body: Center(
        //     child: Text(
        //       'Hello World',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 30.0,
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
