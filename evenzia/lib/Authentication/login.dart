import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Src/Media/mediaHome.dart';
import '../Src/advisor/advisorhome.dart';
import '../Src/dep_rep/dep_rep_home.dart';
import '../Src/secretory/secretoryHome.dart';
import '../Src/student/studentHome.dart';
import '../constant/custumNextButton.dart';
import 'package:http/http.dart' as http;

import '../constant/urlConstant.dart';

class LoginPage extends StatefulWidget {
  String logUrl;
  String Usertype;
  LoginPage({Key? key, required this.logUrl, required this.Usertype})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  bool _buttonColor = false;
  bool emailState = false;
  bool passwordState = false;
  bool _emailOnchange = false;
  bool _passwordOnchange = false;
  String username = '';
  String password = "";
  String errorEmail = '';
  String errorPassword = '';
  bool hidePassword = true;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> Login(BuildContext ctx) async {
    print('login');
    final response = await http.post(Uri.parse(UrlConst+widget.logUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': _userController.text,
            'password': _passController.text,
          },
        )
    );
    var jsondata = jsonDecode(response.body);
    print(jsondata);

    if (jsondata['success'] == true) {
      setState(() {
        saveUserData(
          jsondata['token'].toString(),
          jsondata['user']['id'].toString(),
          jsondata['user']['name'],
          jsondata['user']['email'].toString(),
        );
      });

      widget.Usertype == '1'
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => (StudentHome())))
          : widget.Usertype == '2'
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => (MediaHome())))
              : widget.Usertype == '3'
                  ? Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => (DepRepHome())))
                  : widget.Usertype == '4'
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (SecretoryHome())))
                      : widget.Usertype == '5'
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (AdvisorHome())))
                          : null;
      print({
        jsondata['token'].toString(),
        jsondata['user']['id'].toString(),
        jsondata['user']['name'],
        jsondata['user']['email'].toString(),
      });

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message'])));
    } else {

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message'])));
    }
  }

  Future saveUserData(
    token,
    usreid,
    username,
    email,
  ) async {
    print('savedatacall Login');

    print('${username} savedata');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    return await {
      sharedPreferences.setString('token', token),
      sharedPreferences.setString('usreid', usreid),
      sharedPreferences.setString('username', username),
      sharedPreferences.setString('userEmail', email),

      // sharedPreferences.setString('image', image)
    };
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SizedBox space = const SizedBox(
      height: 10,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 190,
                  width: 250,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: NetworkImage(logo), fit: BoxFit.fill)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Evenzia',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: TextFormField(
                  controller: _userController,
                  onChanged: (Email) {
                    setState(() {
                      _emailOnchange = !_emailOnchange;
                      username = _userController.text;
                      Email = _userController.text;
                    });
                    print(Email);
                    Validation1(Email, 'Email');
                    validateEmail(Email);
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    helperText: errorEmail,
                    helperStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              _userController.text.length>5?Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: TextField(
                  obscureText: _isObscure,
                  controller: _passController,
                  onChanged: (Password) {
                    setState(() {
                      _passwordOnchange = !_passwordOnchange;
                      password = _passController.text;
                      Password = _passController.text;
                    });
                    Validation1(Password, 'Password');
                    validatePassword(Password);
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                    helperText: errorPassword,
                    helperStyle: TextStyle(color: Colors.red),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                  ),
                ),
              ):SizedBox(),
              space,
              _passController.text.length>=8 ? Padding(
                  padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
                  child: customNextButton(
                    onPressed: () {
                      Login(context);
                      // setTockendata();
                      Validation(username, password);
                    },
                    buttonName: 'Sign in',
                    buttonColor:true,
                  )):SizedBox(),
              space,
              space,
              space,
              space,
              space,
              space,
              space,

            ],
          ),
        ));
  }

  void Validation(String Email, Pass) {
    if (Email.isEmpty) {
      setState(() {
        errorEmail = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(Email, true)) {
      setState(() {
        errorEmail = "Invalid Email Address";
      });
    } else {}
    if (Pass.isEmpty) {
      setState(() {
        errorPassword = "Password can not be empty";
      });
    } else if (Pass.length < 6) {
      setState(() {
        errorPassword = "Password should be in a valid format";
      });
    } else {
      setState(() {
        // Login(context);
        _buttonColor = true;
        errorEmail = "";
        errorPassword = "";
      });
    }
  }

  void Validation1(String value, type) {
    if (type == "Email") {
      if (value.isEmpty) {
        setState(() {
          // _errorEmail = "Email can not be empty";
          emailState = false;
        });
      }
      if (!EmailValidator.validate(value, true)) {
        print('value inside the email validation>>>' + value);
        setState(() {
          // _errorEmail = "Invalid Email Address";
          emailState = false;
        });
      } else {
        setState(() {
          errorEmail = "";
          emailState = true;
        });
      }
    } else if (type == 'Password') {
      if (value.isEmpty) {
        setState(() {
          errorPassword = "Password can not be empty";
          passwordState = false;
        });
      } else if (value.length < 6) {
        setState(() {
          errorPassword = "";
          passwordState = false;
        });
      } else {
        setState(() {
          passwordState = true;

          errorPassword = "";
        });
      }
    }
    if (emailState == true && passwordState == true) {
      _buttonColor = true;
    } else {
      _buttonColor = false;
    }
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _buttonColor = false;
        errorEmail = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        errorEmail = "";
      });
    } else {
      setState(() {
        errorEmail = "";
      });
    }
  }

  void validatePassword(String val) {
    if (val.isEmpty) {
      setState(() {
        _buttonColor = false;
        errorPassword = "Password can not be empty";
      });
    } else if (val.length < 6) {
      setState(() {
        _buttonColor = false;
        errorPassword = "Password should be in a valid format";
      });
    } else {
      setState(() {
        errorPassword = "";
      });
    }
  }

  Future saveurl(url) async {
    print('savedatacall Login');

    print('${username} savedata');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    return await {
      sharedPreferences.setString('url', url),

      // sharedPreferences.setString('image', image)
    };
  }
}
