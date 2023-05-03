
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/urlConstant.dart';

class ImagePic extends StatefulWidget {
  const ImagePic({Key? key}) : super(key: key);

  @override
  State<ImagePic> createState() => _ImagePicState();
}

class _ImagePicState extends State<ImagePic> {
  final TextEditingController _emailController = TextEditingController();

  String? _token;
  String? _id;
  String? Base64;


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:

      ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          imagefile != null
              ? Container(
            child: Image.file(imagefile!),
          )
              : Container(
            child: Icon(
              Icons.camera_alt_sharp,
              color: Colors.blueAccent,
              size: MediaQuery
                  .of(context)
                  .size
                  .width * .6,
            ),
          ),

          // Text(_locationMessage),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              child: Text('open camara'),
              onPressed: () {
                _getFormcamera();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child: TextField(
              obscureText: false,
              controller: _emailController,
              onChanged: (Password) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.grey),
                helperStyle: TextStyle(color: Colors.red),

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              child: Text('upload'),
              onPressed: () {
                uploadImage(context);

              },
            ),
          ),

        ],
      ),
    );
    // Scaffold(
    //   body: Center(
    //     child: Column(
    //       children: [
    //
    //         SizedBox(height:100,),
    //
    //         MaterialButton(
    //             color: Colors.blue,
    //             child: const Text(
    //                 "Pick Image from Camera",
    //                 style: TextStyle(
    //                     color: Colors.white70, fontWeight: FontWeight.bold
    //                 )
    //             ),
    //             onPressed: (){}
    //             // async {
    //             //   var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    //             //   var res = await uploadImage(file!.path, 'https://evenzia.websitepreview.in/api/media/add-media');
    //             //   setState(() {
    //             //     state = res!;
    //             //     print({res});
    //             //   });
    //             // },
    //             // {
    //             //   pickImage();
    //             // }
    //         ),
    //
    //         Padding(
    //           padding: const EdgeInsets.only(top:5,left:25,right:20),
    //           child: TextField(
    //             onChanged: (email) {
    //               setState(() {
    //
    //               });
    //               print( email);
    //
    //             },
    //             controller: _emailController,
    //             decoration: InputDecoration(
    //               hintText: 'Media Name',
    //               labelText: 'Media Name',
    //               labelStyle: TextStyle(color: Colors.grey),
    //
    //               helperStyle: TextStyle(color: Colors.red),
    //             ),
    //           ),
    //         ),
    //
    //         ElevatedButton(onPressed: (){
    //           // UploadMedia(context);
    //           uploadAll();
    //         }, child: Text('upload'))
    //
    //       ],
    //     ),
    //   )
    // );

  }


  final String phpEndPoint = 'https://evenzia.websitepreview.in/api/media/add-media';
  var loginId;
  File? imagefile;


  final picker = ImagePicker();


  void _getFormcamera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print({'_getFormcamera', pickedFile!.path});
    setState(() {
      imagefile = File(pickedFile.path);
    });
  }


  Future<void> uploadImage(BuildContext ctx) async {
    print({'uploadImage', imagefile,_token});

    // List<int> imageBytes = imagefile!.readAsBytesSync();
    // String baseimage = base64Encode(imageBytes);
    // final bytes = imagefile!.readAsBytesSync();
    // String base64Image = "data:image/png;base64," + base64Encode(bytes);

    // debugPrint("img_pan : $base64Image");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse(UrlConst+'media/add-media')
    );
    request.fields.addAll({
      'name': _emailController.text
    });
    request.files.add(await http.MultipartFile.fromPath(
        'image',imagefile!.path ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text('New Media created successfully')));
      print({'resp',await response.stream.bytesToString()});
    }
    else {
      print(response.reasonPhrase);
    }
  }
}