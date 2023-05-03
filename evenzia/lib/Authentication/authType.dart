import 'package:evenzia/Authentication/signUp.dart';
import 'package:flutter/material.dart';

import '../constant/custumNextButton.dart';
import '../constant/urlConstant.dart';
import 'login.dart';
class authType extends StatefulWidget {
   String userType;
   String logUrl;
  authType({Key? key,required this.userType,required this.logUrl}) : super(key: key);

  @override
  State<authType> createState() => _authTypeState();
}

class _authTypeState extends State<authType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 150,
                  width: 250,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: NetworkImage(
                            logo,
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Evenzia',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Text(
              //         ' Select Your Roll',
              //         style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.blue.shade200),
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 200,
                  child: customNextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => (
                          LoginPage(
                            logUrl: widget.logUrl+'/login',
                            Usertype: widget.userType,))));


                    },
                    buttonName: 'Login',
                    buttonColor: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 200,
                  child: customNextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => (SignUp(
                        typeUser:widget.userType,
                        Url:widget.logUrl+'/register',
                      ))));
                    },
                    buttonName: 'Signup',
                    buttonColor: true,
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
