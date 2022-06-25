import 'package:flutter/material.dart';
import 'package:flutter_app2/screen/loginpage.dart';
import 'package:flutter_app2/screen/tabberpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? email = prefs.getString('email');
  // print(email);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: email == null ? LoginPage() : TabberPage(),
    );
  }
}
