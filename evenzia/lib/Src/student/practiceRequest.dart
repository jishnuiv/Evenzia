import 'dart:convert';
import 'package:evenzia/constant/urlConstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/myColor.dart';
class PracticeRequest extends StatefulWidget {
  const PracticeRequest({Key? key}) : super(key: key);

  @override
  State<PracticeRequest> createState() => _PracticeRequestState();

}


class _PracticeRequestState extends State<PracticeRequest> {
  void initState() {
    getSaveUserData().then((value) => viewPracticeRequestStatus(context));
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


  Future<void> viewPracticeRequestStatus(BuildContext ctx) async {
    // print({'payment list', _token,widget.uri});
    final response = await http.post(
        Uri.parse('${UrlConst}student/event/practice-status-list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_token}' ,

          // _token.toString()
        },
        body:jsonEncode(
            <String, String> {
              'student_id': _id.toString()
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
      appBar: AppBar(centerTitle: true,
          title: const Text('Request Status',),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
body: FutureBuilder(
    future: viewPracticeRequestStatus(context),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      // print(snapshot.data);
      if (!snapshot.hasData) {
        print(snapshot.error);
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
            itemCount: snapshot.data['events'].length,
            itemBuilder: (BuildContext context, int index) {

              // if(snapshot.data['data'].length =!1) {
              return CustomCard(
                title: snapshot.data['events'][index]['event'],
                date:snapshot.data['events'][index]['date'],
                organizerName:'',
                description:'',
                eventNAme: '',
                organizerId: '',
                Stat: false,
                id: '',
                type: '',
                onPressed: (){},
                // buttons:snapshot.data['data'][index]['status'].toString(),

                accept: () {

                  setState(() {
                    Evntid=snapshot.data['events'][index]['id'].toString();
                    // participateEvents(context);
                  });
                },
                reject: () {  }, buttons: snapshot.data['events'][index]['status'].toString(),
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
class CustomCard extends StatelessWidget {
  bool Stat;
  String title;
  String  date;
  String description;
  String organizerId;
  String id;
  String type;
  String organizerName;
  String eventNAme;
  String buttons;
  final GestureTapCallback? onPressed;
  final GestureTapCallback? accept;
  final GestureTapCallback? reject;
  CustomCard({Key? key,
    this.onPressed,
    required this.eventNAme,
    required this.Stat,
    required this.date,
    required this.title,
    required this.description,
    required this.organizerId,
    required this.organizerName,
    required this.id,
    required this.buttons,
    required this.type,
    required this.accept,
    required this.reject,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        width:width/4 ,decoration:
      BoxDecoration( gradient:
      LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: tileColors)
        ,borderRadius:BorderRadius.all(Radius.circular(10)),
      ),
        child:
        RawMaterialButton(onPressed: onPressed
          ,splashColor: Colors.white,
          child: Column(children: [
            Row(mainAxisAlignment:MainAxisAlignment.center ,
              children:  [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('${organizerName}',style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),),
                )

              ],),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Date:   ',style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500),),
                  Text(date,style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500),),

                ],),
            ),

            Divider(thickness: 3,color:Colors.white24 ,),


            Padding(
              padding: const EdgeInsets.all(3.0),
              // child: Row(mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Event Name:',style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500)),
              //     Text(title,style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500))
              //   ],),
            ),
            Stat==true ?    Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Amount: ',style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500)),
                  Text(id,style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500))
                ],),
            ):SizedBox(),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Description:',style:TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500)),
                  Column(
                    children: [
                      Text(description,style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500)),
                    ],
                  )
                ],),
            ),
            buttons=='0'? Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: accept, child: const Text('Rejected'),
                    style:ElevatedButton.styleFrom(
                      primary: Colors.red),),

                ],
              ),
            ):buttons=='1'?Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(color: Colors.green,height: 50,width: 150,child:
                  Center(child: Text('Requested',style: TextStyle(color: Colors.white),)),)
                ],
              ),
            ):buttons=='2'?Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(color: Colors.red,height: 50,width: 150,child: Center(child: Text('Accepted',style: TextStyle(color: Colors.white))),)
                ],
              ),
            ):SizedBox(),
            SizedBox(height: 10,)

          ],),
        ),
      ),
    );
  }
}