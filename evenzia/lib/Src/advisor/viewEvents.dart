import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
class viewEvents extends StatefulWidget {
  String? eventUrl;
   viewEvents({Key? key,required this.eventUrl}) : super(key: key);

  @override
  State<viewEvents> createState() => _viewEventsState();
}

class _viewEventsState extends State<viewEvents> {
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
        Uri.parse(UrlConst+widget.eventUrl.toString()),
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
    print({"Response events: ", data});
    print(data);
    return data;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(centerTitle: true,
          title: const Text('Event',),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
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
                      date:snapshot.data['data'][index]['created_at'],
                      organizerName:snapshot.data['data'][index]['name'],
                      description:snapshot.data['data'][index]['description'],
                      eventNAme: '',
                      organizerId: '',
                      Stat: false,
                      id: '',
                      type: '',
                      onPressed: (){},
                      buttons:'',

                      accept: () {

                      },
                      reject: () {  },
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
                  ElevatedButton(onPressed: accept, child: const Text('Participate'),
                    style:ElevatedButton.styleFrom(
                      primary: Colors.greenAccent.shade400,),),
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