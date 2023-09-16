import 'dart:convert';
import 'package:ass1/Map.dart';
import 'package:ass1/profile.dart';
import 'package:ass1/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  bool checked = false;

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenPage();
}

class LoginScreenPage extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _checkData() async {
    var url = "http://192.168.1.8:80/project/checkData.php";
    var res = await http.post(Uri.parse(url),
        body: {"email": email.text, "password": password.text});


    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      print(res.body);

      if (red != null) {
        print("gamed");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => profile(email.text, password.text)));
      } else {
        print("m3lesh");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Login',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(70.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: email,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueGrey,
                        ),
                        filled: true,
                        fillColor: Colors.white60,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: password,
                    obscureText: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.blueGrey,
                        ),
                        filled: true,
                        fillColor: Colors.white60,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set the background color
                    ),
                    onPressed: () {
                      _checkData();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Has no account',
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen(222,222)));
                        },
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ],
              ),
            )
          ])
        ],
      ),
    );
    throw UnimplementedError();
  }
}
