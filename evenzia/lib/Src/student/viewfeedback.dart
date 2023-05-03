import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
class viewFeedback extends StatefulWidget{
  String uri;
   viewFeedback({Key? key,required this.uri}) : super(key: key);

  @override
  State<viewFeedback> createState() => _viewFeedbackState();
}

class _viewFeedbackState extends State<viewFeedback> {
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

  Future<void> viewFeedback(BuildContext ctx) async {
    print({'payment list', _token,widget.uri});
    final response = await http.post(
        Uri.parse(UrlConst+widget.uri.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_token}' ,

        },
        body:jsonEncode(
            <String, String> {
              "type":"1"
            })
    );

    var jsondata = jsonDecode(response.body);
    print(jsondata['success']);

    var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"Response events: ", data});
    print(data);
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title:const Text(
            'Feedback',
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
          future: viewFeedback(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
            if (!snapshot.hasData) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext context, int index) {


                     return  feedbackCard(text:snapshot.data['data'][index]['message'],
                       date:''
                       // snapshot.data['data'][index]['created_at'],
                     );

                  });
            }
          }),

    );
  }
}
 class feedbackCard extends StatelessWidget {
  String text,date;
    feedbackCard({Key? key,required this.text,required this.date}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(30.0),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(5.0),
         child: Container(

           width: 300,
           margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5.0),
             color: Colors.white,
             boxShadow: const [
               BoxShadow(
                 color: Colors.grey,
                 offset: Offset(0.0, 1.0), //(x,y)
                 blurRadius: 6.0,
               ),
             ],

           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 Row(mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(text),
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text(date),
                     ],
                   ),
                 )
               ],
             ),
           ),
         ),
       ),
     );
   }
 }
