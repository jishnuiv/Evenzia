import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../constant/myColor.dart';
import '../../constant/urlConstant.dart';
class imagefile extends StatefulWidget {
  String? imgUrl;

   imagefile({Key? key,required this.imgUrl}) : super(key: key);

  @override
  State<imagefile> createState() => _imagefileState();
}

class _imagefileState extends State<imagefile> {
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


  Future<void> viewMedia(BuildContext ctx) async {
    print({'viewMedia', _token});
    final response = await http.post(
        Uri.parse(UrlConst+widget.imgUrl.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_token}' ,
          // _token.toString()
        },
        body:jsonEncode(
            <String, String> {
              "model":"media"
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
  Future<void> deleteMedia(BuildContext ctx,String id) async {
    print({'deleteMedia', _token});
    final response = await http.delete(
        Uri.parse(UrlConst+'media/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_token}' ,
          // _token.toString()
        },
        body:jsonEncode(
            <String, String> {
              "id":id
            })
    );

    var jsondata = jsonDecode(response.body);
    print(jsondata);

    var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"deleteMedia events: ", data});

  }





  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
      AppBar(centerTitle: true,
          title: const Text('Media',),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
      body: Container(

        child: FutureBuilder(
            future: viewMedia(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(snapshot.data);
              if (!snapshot.hasData) {
                print(snapshot.error);
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data['data']['data'].length,
                    itemBuilder: (BuildContext context, int index) {

                      // if(snapshot.data['data'].length =!1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          height: height/2,width: width,
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          // snapshot.data['data'][index]['id'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                          snapshot.data['data']['data'][index]['title'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                      ),
                                    ],),
                                ),
                                Container(
                                  height: height/3,width: width,
                                  child: PhotoView(
                                    imageProvider: NetworkImage(
                                        snapshot.data['data']['data'][index]['image_url'])
                                  ),
                                ),
                               widget.imgUrl!='student/media/list' ?Row(mainAxisAlignment: MainAxisAlignment.end,children: [IconButton(onPressed: (){

                                  deleteMedia(context,snapshot.data['data']['data'][index]['id'].toString());
                                  setState(() {
                                    viewMedia(context);
                                  });
                                }, icon:Icon(Icons.delete_forever))],):SizedBox(),
                                SizedBox(height:30,),
                                Container(height: 2,width: width,color: Colors.black26,)
                              ],
                            )),
                      );



                      // }
                      // else {
                      //   return Text('no data');
                      //
                      // }
                    });
              }
            }),
      ),
    );
  }
}




