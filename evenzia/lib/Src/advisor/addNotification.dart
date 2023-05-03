import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/custumNextButton.dart';
import '../../constant/urlConstant.dart';


class AddAdvisorNotification extends StatefulWidget {
  String? Uri;
   AddAdvisorNotification({Key? key,required this.Uri}) : super(key: key);

  @override
  State<AddAdvisorNotification> createState() => _AddAdvisorNotificationState();
}

class _AddAdvisorNotificationState extends State<AddAdvisorNotification> {
  @override
  void initState() {
    getSaveUserData();
    // TODO: implement initState
    super.initState();
  }
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
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
    map['remark'] = _remarkController.text;
    map['date'] = _dateController.text;
    print({'addNotification', map});
    final response = await http.post(Uri.parse(UrlConst+widget.Uri.toString()),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
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
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: TextField(
                obscureText: false,
                controller: _remarkController,
                onChanged: (Password) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Remark',
                  labelText: 'Remark',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.red),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5,left:25,right:20),
              child: TextField(
                onChanged: (email) {
                  setState(() {

                  });
                  print( email);

                },
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: 'Pick your Date ',
                  labelText: 'Pick your Date ',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  var date =  await showDatePicker(
                      context: context,
                      initialDate:DateTime.now(),
                      firstDate:DateTime(1900),
                      lastDate: DateTime(2100));
                  _dateController.text=date.toString().substring(0,10);
                  print(_dateController.text);
                },
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
                    buttonName: 'Add Notification',
                    buttonColor: true,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
