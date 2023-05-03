import 'dart:convert';

import 'package:evenzia/constant/custumNextButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
class AddResult extends StatefulWidget {
  String EvntId;
  String getlistUrl;
  String addReportUrl;
 AddResult({Key? key,
   required this.EvntId,
   required this.getlistUrl,
   required this.addReportUrl,
 }) : super(key: key);

  @override
  State<AddResult> createState() => _AddResultState();
}

class _AddResultState extends State<AddResult> {
  @override
  void initState() {
    getSaveUserData();
    // TODO: implement initState
    super.initState();
    print(widget.EvntId.toString());
  }
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
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


  Future<void> getList(BuildContext ctx) async {
    var map = new Map<String, dynamic>();
    map['id'] =widget.EvntId.toString();

    print({'getList', map,widget.getlistUrl});
    final response = await http.post(Uri.parse(UrlConst+widget.getlistUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':'Bearer $_token'
        },
        body: map);
    var jsondata = jsonDecode(response.body);
    print({'getList', jsondata});

    if (jsondata['success'] == true) {
      return jsondata;
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message'])));
    }
  }
  Future<void> subResult(BuildContext ctx) async {
    var map = new Map<String, dynamic>();
    map['student_id'] =_studentController.text;
    map['event_id'] =widget.EvntId.toString();
    map['grade'] =_remarkController.text;
    map['position']=_positionController.text;

    print({'subResult', map});
    final response = await http.post(Uri.parse(UrlConst+widget.addReportUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':'Bearer $_token'
        },
        body: map);
    var jsondata = jsonDecode(response.body);
    print({'subResult', jsondata});

    if (jsondata['success'] == true) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message']))
      );
      return jsondata;

    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(jsondata['message']))
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: const Text('Add Result',),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),

      body: ListView(children: [

        Padding(
          padding: const EdgeInsets.only(top:5,left:25,right:20),
          child: TextField(
            onChanged: (email) {
              setState(() {

              });
              print( email);

            },
            controller: _remarkController,
            decoration: InputDecoration(
              hintText: 'Grade',
              labelText: 'Grade',
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
            controller: _positionController,
            decoration: const InputDecoration(
              hintText: 'Position',
              labelText: 'Position',
              labelStyle: TextStyle(color: Colors.grey),

              helperStyle: TextStyle(color: Colors.red),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:5,left:25,right:20),
          child:




          TextField(

            onTap: () {
              print('test');
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Students"),
                  content: Container(height:150 ,width: 100,
                    child: FutureBuilder(future:getList(context) ,
                        builder:(BuildContext context, AsyncSnapshot snapshot){
                          // print(snapshot.data);
                          if (!snapshot.hasData) {
                            print({'err',snapshot.error});
                            return Center(child: CircularProgressIndicator());
                          }

                          else{
                            return ListView.builder(
                                itemCount: snapshot.data['data'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        _studentController.text=snapshot.data['data'][index]['id'].toString();
                                      });


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child:
                                      ListTile(

                                        // trailing: Text('Id:${snapshot.data['departments'][index]['id']}'),
                                        title: Text('${snapshot.data['data'][index]['name']}',),
                                      ),
                                    ),
                                  );

                                });
                          }
                        } ),
                  ),
                  // const Text("You have raised a Alert Dialog Box"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(14),
                        child: const Text("submit",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              );







              // Validation1(email,'Email');
            },
            controller: _studentController,
            decoration: const InputDecoration(
              hintText: 'Student Id',
              labelText: 'Student Id',
              labelStyle: TextStyle(color: Colors.grey),
              // helperText: _errorEmail,
              helperStyle: TextStyle(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 50,),
        Container(height: 50,
          child: customNextButton(onPressed:(){
            subResult(context);
          }, buttonName: 'Submit', buttonColor: true),
        )

      ],),
    );
  }
}
