import 'dart:convert';

import 'package:evenzia/Src/dep_rep/viewReport.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
import 'approveRequest.dart';

class GenerateReport extends StatefulWidget {
  String reportUrl;
   GenerateReport({Key? key,required this.reportUrl}) : super(key: key);

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
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

  String? Evntid;
  Future<void> viewEvents(BuildContext ctx) async {
    print({
      'viewEvent',
      _token,
    });
    final response = await http.post(
      Uri.parse(UrlConst + 'department-rep/events'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_token}',
      },
    );

    var jsondata = jsonDecode(response.body);
    print(jsondata['success']);

    var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"Response events: ", data});
    print(data);
    return data;
  }

  Future<void> reoport(id) async {
    print({
      'reoport',
      _token,
    });
    final response =
        await http.post(Uri.parse(UrlConst +widget.reportUrl ),

            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_token}',
            },
            body: jsonEncode(<String, String>{"event_id": id.toString()}));

    var jsondata = jsonDecode(response.body);
    print({'event_id', jsondata['success']});

    if (jsondata['success'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => viewReport(
                    Name:jsondata['data']['event_name'],
                    Date:jsondata['data']['date'],
                    Winner:jsondata['data']['name'],
                    Grade:jsondata['data']['grade'],
                  )));
    }
    // var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"event_id: ", data});

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Report',
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: tileColors),
            ),
          )),
      body: FutureBuilder(
          future: viewEvents(context),
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
                      title: snapshot.data['data'][index]['name'],
                      date: snapshot.data['data'][index]['created_at'],
                      organizerName: snapshot.data['data'][index]['name'],
                      description: snapshot.data['data'][index]['description'],
                      eventNAme: '',
                      organizerId: '',
                      Stat: false,
                      id: '',
                      type: '',
                      onPressed: () {},
                      onPress: () {
                        reoport(
                            snapshot.data['data'][index]['id'],

                             );
                      },
                      bname: 'View Report',
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
