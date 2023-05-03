import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
class imgtest extends StatefulWidget {
  const imgtest({Key? key}) : super(key: key);

  @override
  State<imgtest> createState() => _imgtestState();
}

class _imgtestState extends State<imgtest> {

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
        print({'uservvv',_token,_id});

      });

    }
  }

  File ?_photo;
  String ?photoBase64;
  int _counter = 0;
  File ?imageResized;
  final ImagePicker _picker = ImagePicker();
  Future getImage(ImageSource source) async {
    XFile? photo = await ImagePicker().pickImage(source: source);

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);



    imageResized = await FlutterNativeImage.compressImage(photo!.path,
        quality: 100, targetWidth: 120, targetHeight: 120);
    print({'test',image.toString()});
    setState(() {
      _photo = photo as File?;


      List<int> imageBytes = imageResized!.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
      print({'test',photoBase64});
    });
  }

  void _incrementCounter() {
    getImage(ImageSource.camera);
    setState(() {
      _counter++;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageResized == null ? Container() : Image.file(imageResized!),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }


  Future<void> uploadImage() async {
    print('uploadImage');
    try {

      File image = File('path/to/image.jpg');
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);


      // String base64Image =  "data:image/png;base64,"+base64Encode(bytes);

      print("img_pan : $base64Image");

      var param = {
        'image': base64Image,
        'name': 'latitude',
      };
      debugPrint(param.toString());
      var response = await http.post(Uri.parse('https://evenzia.websitepreview.in/api/media/add-media'),
          headers: <String, String>{
            // 'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization':'Bearer $_token'
          },
          body: param );
      // print(baseimage);
      print("response body :${response.body}");
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print(e.toString());
    }
  }



  // Future<void> getLostData() async {
  //   final LostDataResponse response =
  //   await _picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.files != null) {
  //     for (final XFile file in response.files!) {
  //       _handleFile(file);
  //
  //     }
  //   } else {
  //     _handleError(response.exception);
  //   }
  // }




}
