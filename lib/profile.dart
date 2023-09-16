import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  final String email;
  final String password;

  const profile(this.email, this.password, {Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}



class _profileState extends State<profile> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactPersonNameController = new TextEditingController();
  TextEditingController companyIndustryController = TextEditingController();
  TextEditingController contactPersonPhoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companySizeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String id = "";
  String companyName = "";
  String contactPersonName = "";
  String companyIndustry = "";
  String contactPersonPhoneNumber = "";
  String email = "";
  String companyAddress = "";
  String companySize = "";
  String password = "";
  String longitude = "";
  String latitude = "";

  List person = [];
  String image = 'test.jpg';

  @override
  void initState() {
    super.initState();
    _getData();
  }


  _getData() async {
    var url = "http://192.168.1.8:80/project/getData.php";
    var res = await http.post(Uri.parse(url),
        body: {"email": widget.email, "password": widget.password});

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        person.addAll(red);
      });

      id = person[0]['id'];
      companyName = person[0]['companyName'];
      contactPersonName = person[0]['contactPersonName'];
      companyIndustry = person[0]['companyIndustry'];
      contactPersonPhoneNumber = person[0]['contactPersonPhoneNumber'];
      email = person[0]['email'];
      companyAddress = person[0]['companyAddress'];
      companySize = person[0]['companySize'];
      password = person[0]['password'];
      longitude = person[0]['longitude'];
      latitude = person[0]['latitude'];
      image = person[0]['img'];
      if (image == "") {
        image = "test.jpg";
      } else {
        image = "image.jpg";
      }
    }
  }

  XFile? img;
  ImagePicker imagePicker = ImagePicker();

  _editData(String field, String value) async {
    var url = "http://192.168.1.8:80/project/editData.php";
    var res = await http.post(Uri.parse(url), body: {
      "email": widget.email,
      "password": widget.password,
      "field": field,
      "value": value
    });

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);
      print(red);

      setState(() {
        switch (field) {
          case "CompanyName":
            companyName = value;
            break;
          case "contactPersonName":
            contactPersonName = value;
            break;
          case "companyIndustry":
            companyIndustry = value;
            break;
          case "contactPersonPhoneNumber":
            contactPersonPhoneNumber = value;
            break;
          case "email":
            email = value;
            break;
          case "companyAddress":
            companyAddress = value;
            break;
          case "companySize":
            companySize = value;
            break;
          case "password":
            password = value;
            break;
        }
      });
    }
  }

  showDialogFunction(String field, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              child: Column(
                children: [
                  Text(field),
                  TextFormField(
                    controller: controller,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _editData(field, controller.text);
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Edit"))
                ],
              ),
            ),
          );
        });
  }

  getImg(email, password) async {
    final pic = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      img = XFile(pic!.path);
    });
    addImage(email, password);
  }

  // Future UploadImage() async {
  //   var url = "http://192.168.1.2:8080/project/addImage.php";
  //   var request = http.MultipartRequest("post", Uri.parse(url));
  //   request.fields['email'] = email;
  //   request.fields['password'] = password;
  //   var pic = await http.MultipartFile.fromPath('img', img!.path);
  //   String picture = img!.path;
  //   image = path.basename(picture);
  //   request.files.add(pic);
  //   var res = await request.send();
  //   if (res.statusCode == 200) {
  //     print("Done");
  //   }
  // }

  Future UploadImage() async {
    var url = "http://192.168.1.8:80/project/addImage.php";
    var request = http.MultipartRequest("post", Uri.parse(url));

    request.fields['email'] = email;
    request.fields['password'] = password;

    var imageBytes = await img!.readAsBytes();

    request.files.add(http.MultipartFile.fromBytes('img', imageBytes, filename: "image.jpg"));

    var res = await request.send();

    if (res.statusCode == 200) {
      print("Done");
      setState(() {
        theImageFunction();

      });
    }
  }

  theImageFunction(){
    return CircleAvatar(
      radius: 70,
      foregroundImage: NetworkImage("http://192.168.1.8:80/project/img/$image"),
      child: const Text(
        "ABC",
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  addImage(email, password) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      UploadImage();
                      Navigator.pop(context);
                    },
                    child: const Text("Upload")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            ),
          );
        });
  }

  double fontSize = 16;
  double height = 15;

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: height),
              Center(
                child: InkWell(
                  onTap: () {
                    getImg(email, password);
                  },
                  child: theImageFunction()
                ),
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Company Name: $companyName',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showDialogFunction(
                            "CompanyName", companyNameController);
                      });
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Contact Person Name: $contactPersonName',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction(
                          "contactPersonName", contactPersonNameController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Company Industry: $companyIndustry',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction(
                          "companyIndustry", companyIndustryController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Contact Person Phone Number: $contactPersonPhoneNumber',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction("contactPersonPhoneNumber",
                          contactPersonPhoneNumberController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Email: $email',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction("email", emailController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Company Address: $companyAddress',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction("email", emailController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Company Size: $companySize',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction("companySize", companySizeController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: height),
              Row(
                children: [
                  Text('Password: $password',
                      style:
                          TextStyle(fontSize: fontSize, color: Colors.white)),
                  IconButton(
                    onPressed: () {
                      showDialogFunction("password", passwordController);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
