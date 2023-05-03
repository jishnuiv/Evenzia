import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/custumNextButton.dart';
import '../../constant/urlConstant.dart';
class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  void initState() {
    getSaveUserData();
    // TODO: implement initState
    super.initState();
  }
  final TextEditingController _messageController = TextEditingController();
  String ?_token;
  String ?_id;

  Future getSaveUserData() async {
    print('getdatacall');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    {
      String? token = sharedPreferences.getString(
        'token',
      );

      String? id = sharedPreferences.getString(
        'usreid',
      );
      setState(() {
        _token = token.toString();
        _id = id.toString();
        print({'uservvv',_token,_id});

      });

    }
  }


  Future<void> addNotification(BuildContext ctx) async {
    var map = new Map<String, dynamic>();
    map['message'] = _messageController.text;
    print({'addNotification', map});
    final response = await http.post(Uri.parse(UrlConst+'student/feedback'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization':'Bearer $_token'
        },
        body: map);
    var jsondata = jsonDecode(response.body);
    print({'resp', jsondata});

    if (jsondata['success'] == true) {
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(jsondata['message']),
            actions: [
              FlatButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
      setState(() {});

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => (OrganisationHome())));

    } else {
      // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      //     behavior: SnackBarBehavior.fixed,
      //
      //     content: Text( 'Authentication Failed')));

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(title:Text('Notification'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height:190,
                width: 250,

                decoration:  const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),

                    image: DecorationImage(
                        image: NetworkImage(logo), fit: BoxFit.fill)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: TextFormField(
                controller: _messageController,
                onChanged: (Email) {
                  setState(() {});
                  print(Email);
                },
                decoration: const InputDecoration(
                  hintText: 'Message',
                  labelText: 'Message',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.red),
                ),
              ),
            ),
            spacer,
            spacer,
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
                child: Container(width: 200,height: 60,
                  child: customNextButton(
                    onPressed: () {
                      addNotification(context);
                    },
                    buttonName: 'Add feedback',
                    buttonColor: true,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
