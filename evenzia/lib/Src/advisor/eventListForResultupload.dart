import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
import 'addResult.dart';


class EventListViews extends StatefulWidget {
  String? EventList;
  String? roll;
   EventListViews({Key? key,
     required this.EventList,
     required this.roll
   }) : super(key: key);

  @override
  State<EventListViews> createState() => _EventListViewsState();
}

class _EventListViewsState extends State<EventListViews> {

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
    print({'viewEvent', _token,});
    final response = await http.post(
      Uri.parse(UrlConst+widget.EventList.toString()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_token}' ,

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(centerTitle: true,
           title: const Text('',),
           flexibleSpace: Container(
             decoration:  BoxDecoration(
               gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors:tileColors),
             ),)
       ),


      body:FutureBuilder(
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
                      title: '',
                      date:snapshot.data['data'][index]['created_at'],
                      organizerName:snapshot.data['data'][index]['name'],
                      description:snapshot.data['data'][index]['created_at'],
                      eventNAme: snapshot.data['data'][index]['name'],
                      organizerId: '',
                      Stat: false,
                      id: '',
                      type: '', bname: 'Add Report',
                      onPress: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      widget.roll=='1'?    AddResult(EvntId: snapshot.data['data'][index]['id'].toString(),
                              getlistUrl:'advisor/participated-students',
                              addReportUrl:'advisor/add-result',):
                          AddResult(EvntId: snapshot.data['data'][index]['id'].toString(),
                        getlistUrl:'secretary/participated-students',
                        addReportUrl:'secretary/add-result',)




                        ));


                      },
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
  String bname;
  String  date;
  String description;
  String organizerId;
  String id;
  String type;
  String organizerName;
  String eventNAme;
  final GestureTapCallback? onPressed;
  final GestureTapCallback? onPress;
  CustomCard({Key? key,
    this.onPressed,
    this.onPress,
    required this.eventNAme,
    required this.bname,
    required this.Stat,
    required this.date,
    required this.title,
    required this.description,
    required this.organizerId,
    required this.organizerName,
    required this.id,
    required this.type,


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
          colors: tileColors
      )
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
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],),
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
              padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(onTap:onPress ,

                    child: Container(color: Colors.green,height: 50,width: 150,child:
                    Center(child: Text(bname,style: TextStyle(color: Colors.white),)),),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,)

          ],),
        ),
      ),
    );
  }
}