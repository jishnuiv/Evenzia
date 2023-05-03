import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/myColor.dart';
import '../../constant/notificationTile.dart';
import '../../constant/urlConstant.dart';


class ViewNotification extends StatefulWidget {
  String ? uri;
   ViewNotification({Key? key,required this.uri}) : super(key: key);

  @override
  State<ViewNotification> createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  @override
  void initState() {
    getSaveUserData();
    super.initState();
  }

  String? _token;
  String? _id;
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
        print({'uservvv', _token, _id});
      });
    }
  }

  Future<void> viewNotification(BuildContext ctx) async {
    print({'payment list', _token,widget.uri});
    final response = await http.get(
      Uri.parse(UrlConst+widget.uri.toString()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_token}' ,
            // _token.toString()
      },
    );

    var jsondata = jsonDecode(response.body);
    print(jsondata['success']);

    var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"Response : ", data});
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(centerTitle: true,
        title: const Text('View Notification',),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
      body: FutureBuilder(
          future: viewNotification(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext context, int index) {

                  // if(snapshot.data['data'].length =!1) {
                     return CustomCard(
                       title: '',
                       date:snapshot.data['data'][index]['date'],
                       organizerName:snapshot.data['data'][index]['message'],
                       description:snapshot.data['data'][index]['remark'],
                       eventNAme: '',
                       organizerId: '',
                       Stat: false,
                       id: '',
                       type: '',
                     );

                  // }
                  // else {
                  //   return Text('no data');
                  //
                  // }
                  });
            }
          }),
    );
  }
}
