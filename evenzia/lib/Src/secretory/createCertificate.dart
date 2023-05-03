import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/urlConstant.dart';


class filePic extends StatefulWidget {
  String? viewEventUrl;
  String? viewListUrl;
  String? submitFileUrl;
  filePic({Key? key,required this.submitFileUrl,required this.viewEventUrl,required this.viewListUrl}) : super(key: key);

  @override
  State<filePic> createState() => _magePicStateState();
}

class _magePicStateState extends State<filePic> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
   final TextEditingController _studentController = TextEditingController();
  String? _token;
  String? _id;
  String? Base64;
   bool ?stat=false;
      File?_file;
  void initState() {
    getSaveUserData();

    super.initState();
  }

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
  Future<void> viewEvents(BuildContext ctx) async {
    print({'viewEvents', _token,});
    final response = await http.post(
        Uri.parse(UrlConst+widget.viewEventUrl.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_token}' ,
          // _token.toString()
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


  Future<void> getList(BuildContext ctx,id) async {
    var map = new Map<String, dynamic>();
    map['id'] =id.toString();

    print({'getList', map});
    final response = await http.post(Uri.parse(UrlConst+widget.viewListUrl.toString()
        // 'secretary/participated-students'
    ),
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          // Text(_locationMessage),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              child: Text('Pick File'),
              onPressed: () {
                chooseFileUsingFilePicker();
              },
            ),
          ),
          objFile!=null ?   Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child:  TextField(

              onTap: () {
                print('test');
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Event "),
                    content: Container(height:150 ,width: 100,
                      child: FutureBuilder(
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
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          _eventController.text=snapshot.data['data'][index]['id'].toString();
                                          stat==true;
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

                                    // }
                                    // else {
                                    //   return Text('no data');
                                    //
                                    // }
                                  });
                            }
                          }),
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
              controller: _eventController,
              decoration: const InputDecoration(
                hintText: 'Event id',
                labelText: 'Event id',
                labelStyle: TextStyle(color: Colors.grey),
                // helperText: _errorEmail,
                helperStyle: TextStyle(color: Colors.red),
              ),
            ),
          ):SizedBox(),
          _eventController.text.length !=0?       Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child:  TextField(

              onTap: () {
                print('test');
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Student List"),
                    content: Container(height:150 ,width: 100,
                      child: FutureBuilder(future:getList(context,_eventController.text) ,
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
          ):SizedBox(),

          _studentController.text.length!=0?     Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              child: Text('upload'),
              onPressed: () {
                uploadfile(context);
              },
            ),
          ):SizedBox(),

        ],
      ),
    );


  }
  PlatformFile? objFile;
  final picker = ImagePicker();
  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );



    if (result != null) {
      setState(() {
         objFile = result.files.single;
         print(objFile?.path);
      });
    }
  }








  final String phpEndPoint = 'https://evenzia.websitepreview.in/api/media/add-media';
  var loginId;
  File? imagefile;


  Future<void> uploadfile(BuildContext ctx) async {
    print({'uploadImage', objFile!.path,_token});


    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse(UrlConst+widget.submitFileUrl.toString())
    );
    request.fields.addAll({
      'event_id': _eventController.text,
      'student_id':_studentController.text

    });
    request.files.add(await http.MultipartFile.fromPath(
        'certificate',objFile!.path.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text('Certificate Created Successfully')));
     Navigator.pop(context);

    }
    else {
      print(response.reasonPhrase);
    }
  }
}