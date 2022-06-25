import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app2/helper/databasehelper.dart';
import 'package:flutter_app2/screen/tabberpage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Panggil class DBHelper
  DBHelper dbHelper = DBHelper();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _isLoading = false;
  login() async {
    setState(() {
      _isLoading = true;
    });

    var url = 'https://backendapilaravel-app.herokuapp.com/api/login';
    final response = await http.post(Uri.parse(url), headers: {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json'
    }, body: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    var res = json.decode(response.body);
    if (response.statusCode == 200) {
      // savePref(res['data']['name'], res['user']['name']);
      // print('data : ${res['error']}');
      if (res['user']['status'] == '1') {
        print('Berhasil');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabberPage()));
      } else {
        print('Gagal masuk code 1');
        print(res['user']);
      }
      // return response.body;
    } else {
      print('Status Bukan 200');
      return json.decode(response.body);
    }
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      print('Email: ${_emailController.text}');
      login();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _onPressed() {
    // setState(() {
    //   if (_emailController.text.trim().toLowerCase().isNotEmpty &&
    //       _passwordController.text.trim().toLowerCase().isNotEmpty) {
    //     dbHelper
    //         .loginData(_emailController.text.trim().toLowerCase(),
    //             _passwordController.text.trim().toLowerCase())
    //         .whenComplete(() {
    //       if (dbHelper.status == true) {
    //         print('berhasil');
    //         // Navigator.pushReplacementNamed(context, '/tabberpage');
    //       } else {
    //         print('error');
    //       }
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          // Container(
          //   margin:
          //       EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
          //   child: const Center(
          //     child: Text(
          //       'Dev WebHozz',
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 10,
                  right: 10,
                ),
                child: Form(
                  key: _key,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.cloud_done,
                              size: 40.0,
                              color: Colors.green,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // _onPressed();
                                    check();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.black,
                                      elevation: 2.0,
                                      primary: Colors.amberAccent),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
