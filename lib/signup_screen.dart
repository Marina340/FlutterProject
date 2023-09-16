import 'dart:convert';
import 'package:ass1/login_screen.dart';
import 'package:ass1/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

enum sizes { Micro, Small, Mini, Large }

class SignUpScreen extends StatefulWidget {
  final double lon;
  final double lat;
  SignUpScreen(this.lon, this.lat,{Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => SignUpForm();
}

List<String> _selectedOptions = [];
List<String> _options = ['Micro', 'small', 'Mini', 'Large'];

class SignUpForm extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController companyName = TextEditingController();
  TextEditingController contactPersonName = TextEditingController();
  TextEditingController contactPersonPhoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  double longitude = 0;
  double latitude = 0;
  bool var1 = false;
  bool var2 = false;
  bool var3 = false;
  bool var4 = false;
  String finalVar = "";

  bool _getLocationClicked = false;
  String msg = '';
  sizes? _sizes;

  ////////////////////////////////////////////////
  void _handleGetLocationClick() {
    _getLocationClicked = true;
    setState(() {
      msg = "";
    });
  }

  void _handleSubmitClick() {
    if (_getLocationClicked) {
      // Perform the form submission
      print('Form submitted!');
    } else {
      setState(() {
        _getLocationClicked = true;
        msg = "This Field is Required";
      });
    }
  }

  ////////////////////////////////////////////////
  String getCompanyIndustry() {
    setState(() {
      if (var1) {
        finalVar += "option1";
      }
      if (var2) {
        finalVar += "option2";
      }
      if (var3) {
        finalVar += "option3";
      }
      if (var4) {
        finalVar += "option4";
      }
    });

    return finalVar;
  }

  ////////////////////////////////////////////////

  _addData() async {
    var url = "http://192.168.1.8:80/project/addData.php";
    var res = await http.post(Uri.parse(url), body: {
      "companyName": companyName.text,
      "contactPersonName": contactPersonName.text,
      "companyIndustry": getCompanyIndustry(),
      "contactPersonPhoneNumber": contactPersonPhoneNumber.text,
      "email": email.text,
      "companyAddress": companyAddress.text,
      "companySize": _sizes.toString().split('.').last,
      "password": password.text,
      "longitude": longitude.toString(),
      "latitude": latitude.toString(),
    });

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      print(red);
    }
  }

  ////////////////////////////////////////////////

  void getLocation() async {
    setState(() {
      longitude = widget.lon;
      latitude =widget.lat;
    });
    print(widget.lon);
    print(widget.lat);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(70.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set the background color
                    ),
                    onPressed: () async {
                      _handleGetLocationClick();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Map()));
                      getLocation();
                    },
                    child: Text('Get Location',
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                  SizedBox(height: 10),

                  Text("$msg", style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20),

                  // Add TextFormFields and ElevatedButton here.
                  TextFormField(
                    controller: companyName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Company Name",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: contactPersonName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Contact Person Name",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.white60,
                    child: Row(
                      children: <Widget>[
                        Column(children: [
                          SizedBox(height: 10),
                          Text("Company Industry",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                          SizedBox(height: 10),
                          Row(children: [
                            Checkbox(
                                value: var1,
                                onChanged: (val) {
                                  setState(() {
                                    var1 = !var1;
                                  });
                                  var1 = val ?? false;
                                }),
                            const Text('Option 1')
                          ]),
                          Row(children: [
                            Checkbox(
                                value: var2,
                                onChanged: (val) {
                                  setState(() {
                                    var2 = !var2;
                                  });
                                  var2 = val ?? false;
                                }),
                            const Text('Option 2')
                          ]),
                          Row(children: [
                            Checkbox(
                                value: var3,
                                onChanged: (val) {
                                  setState(() {
                                    var3 = !var3;
                                  });
                                  var3 = val ?? false;
                                }),
                            const Text('Option 3')
                          ]),
                          Row(children: [
                            Checkbox(
                                value: var4,
                                onChanged: (val) {
                                  setState(() {
                                    var4 = !var4;
                                  });
                                  var4 = val ?? false;
                                }),
                            const Text('Option 4')
                          ]),
                        ]),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: contactPersonPhoneNumber,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Contact Person Phone Number",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please Enter a Valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Email",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      String pattern =
                          r'(^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)';
                      RegExp regExp = new RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please Enter a Valid Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: companyAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Company Address",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  Container(
                    color: Colors.white60,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Company Size',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        RadioListTile<sizes>(
                            value: sizes.Micro,
                            groupValue: _sizes,
                            title: Text(sizes.Micro.name),
                            onChanged: (val) {
                              setState(() {
                                _sizes = val;
                              });
                            }),
                        RadioListTile<sizes>(
                            value: sizes.Small,
                            groupValue: _sizes,
                            title: Text(sizes.Small.name),
                            onChanged: (val) {
                              setState(() {
                                _sizes = val;
                              });
                            }),
                        RadioListTile<sizes>(
                            value: sizes.Mini,
                            groupValue: _sizes,
                            title: Text(sizes.Mini.name),
                            onChanged: (val) {
                              setState(() {
                                _sizes = val;
                              });
                            }),
                        RadioListTile<sizes>(
                            value: sizes.Large,
                            groupValue: _sizes,
                            title: Text(sizes.Large.name),
                            onChanged: (val) {
                              setState(() {
                                _sizes = val;
                              });
                            }),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Password",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      String pattern = r'^.{8,}$';
                      RegExp regExp = new RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please Enter a Valid Password, at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white60,
                      labelText: "Confirm Password",
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      String pattern = r'^.{8,}$';
                      RegExp regExp = new RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'This Field is Required';
                      } else if (password.text != confirmPassword.text) {
                        return 'Password Not Match!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set the background color
                    ),
                    onPressed: () {
                      _handleSubmitClick();
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );  getLocation();
                        _addData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }

                    },
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
