import 'package:flutter/material.dart';

import '../constant/custumNextButton.dart';
import '../constant/urlConstant.dart';
import 'authType.dart';
import 'login.dart';

class SelectRoll extends StatefulWidget {
  const SelectRoll({Key? key}) : super(key: key);

  @override
  State<SelectRoll> createState() => _SelectRollState();
}

class _SelectRollState extends State<SelectRoll> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      ' Select Your Roll',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade200),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 200,
                  child: customNextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (
                                  authType(logUrl: 'student',
                                       userType: '1',)
                                  // LoginPage(
                                  //   logUrl: 'student/login',
                                  //   Usertype: '1',
                                  // )
                              )));
                    },
                    buttonName: 'Student',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (authType(
                                    logUrl: 'media',
                                      userType: '2',
                                  ))));
                    },
                    buttonName: 'Media',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (authType(
                                    logUrl: 'department-rep',
                                    userType: '3',
                                  ))));
                    },
                    buttonName: 'Department rep',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (authType(
                                    logUrl: 'secretary',
                                     userType: '4',
                                  ))));
                    },
                    buttonName: 'Secretory',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (authType(
                                    logUrl: 'advisor',
                                     userType: '5',
                                  ))));
                    },
                    buttonName: 'Advisor',
                    buttonColor: true,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
