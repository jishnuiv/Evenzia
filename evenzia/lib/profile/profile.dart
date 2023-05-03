import 'dart:convert';

import 'package:evenzia/constant/custumNextButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../constant/urlConstant.dart';
class Profile extends StatefulWidget {
  String Url;

 Profile({Key? key,required this.Url}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _userNameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _phoneController =TextEditingController();
  final TextEditingController _departmentController=TextEditingController();
   final TextEditingController _doBurlController=TextEditingController();

   String urlMed='media/register';
   String urlStud='student/get-profile';
   String urlDepartment='department-rep/get-profile';
   String urlAdviser='advisor/get-profile';
   String urlSecretary='secretary/get-profile';
   String? roll;
   String? _token;
   String? _id;
   bool? rolls;
@override
  void initState() {
  getSaveUserData().then((value) => profile(context));

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



  String? token;
  Future<void> profile(BuildContext ctx) async {

    final response = await http.post(
        Uri.parse(
            UrlConst+widget.Url.toString(),
                // urlSecretary
                //   urlAdviser
                //  urlDepartment
                // 'student/get-profile'
                // UrlConstwidget.Url
        ),
        headers: <String, String>{
          'Accept':'application/json',
          'Authorization':'Bearer ${_token}'
        },

    );
    var jsondata=jsonDecode(response.body);
    print({'resp',jsondata});
    print(UrlConst+widget.Url.toString(),);


    if(jsondata['type']=='SECRETARY'){
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(

            content: Text(jsondata['message']),
            actions: [

              FlatButton(
                textColor: Colors.black,
                onPressed: () {

                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
     setState(() {
       print('Secretery');
       rolls=false;
        roll=jsondata['type'];
        _userNameController.text=jsondata['data']['profile']['name'];
        _emailController.text=jsondata['data']['profile']['email'];
        jsondata['data']['type'] =='STUDENT'?  _phoneController.text=jsondata['data']['profile']['mobile']:null;
         roll!='SECRETARY'? _departmentController.text=jsondata['data']['profile']['department']['name']:null;
        jsondata['data']['type'] =='STUDENT'?_doBurlController.text=jsondata['data']['profile']['dob']:null;
      });

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => (OrganisationHome())));

    }

    else{
      if(jsondata['type'] =='ADVISOR'){
        setState(() {
        print('advicer');
          rolls=false;
          _userNameController.text=jsondata['data']['profile']['name'];
          _emailController.text=jsondata['data']['profile']['email'];
          jsondata['data']['type'] =='STUDENT'?  _phoneController.text=jsondata['data']['profile']['mobile']:null;
          // roll!='ADVISOR'?_departmentController.text=jsondata['data']['profile']['department']['name']:null;
          jsondata['data']['type'] =='STUDENT'?_doBurlController.text=jsondata['data']['profile']['dob']:null;
        });


      }else{


        setState(() {
          rolls=true;
          _userNameController.text=jsondata['data']['profile']['name'];
          _emailController.text=jsondata['data']['profile']['email'];
          jsondata['data']['type'] =='STUDENT'?  _phoneController.text=jsondata['data']['profile']['mobile']:null;
          _departmentController.text=jsondata['data']['profile']['department']['name'];
          jsondata['data']['type'] =='STUDENT'?_doBurlController.text=jsondata['data']['profile']['dob']:null;
        });



      }




    }

  }

  bool  editStat=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(child: Column(children: [




        SizedBox(height: 80,),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          CircleAvatar(radius: 50,
child: ClipOval(child: Image.network('https://cdn2.iconfinder.com/data/icons/colored-simple-circle-volume-01/128/circle-flat-general-51851bd79-1024.png'),),

          ),



        ],),
        SizedBox(height: 10,),
        // InkWell(
        //
        //   onTap: () {
        //     if(editStat == false)
        //       setState(() {
        //         editStat = true;
        //       });
        //     else{
        //       setState(() {
        //         editStat = false;
        //       });
        //     }
        //   },
        //
        //
        //
        //   child:
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         height: 40,
        //         width: 100,
        //         decoration: BoxDecoration(
        //             border: Border.all(
        //                 color: Colors.blue, width: 1),
        //             borderRadius: BorderRadius.all(
        //                 Radius.circular(30))),
        //         child: Row(
        //           mainAxisAlignment:
        //           MainAxisAlignment.spaceEvenly,
        //           children: [
        //
        //             Center(
        //               child: Text(
        //                 "Edit",
        //                 style: TextStyle(
        //                     color: Colors.blue, fontSize: 15),
        //               ),
        //             ),editStat==true?
        //             Container(height:25,width: 15,
        //                 child: Image.network('http://icons.iconarchive.com/icons/icons8/windows-8/512/Editing-Edit-icon.png')):SizedBox(),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

          TextFieldProfile(
          myHintText: 'Name',
          placeHolder: 'Name',
          textFieldStatus:editStat,
          Textfieldcontroller:_userNameController,
          onChanged: (String ) {  } ,),
        TextFieldProfile(
          myHintText: 'Email',
          placeHolder: 'Email',
          textFieldStatus:editStat,
          Textfieldcontroller:_emailController,
          onChanged: (String ) {  } ,),
        roll=='STUDENT'? TextFieldProfile(
          myHintText: 'Phone',
          placeHolder: 'Phone',
          textFieldStatus:editStat,
          Textfieldcontroller:_phoneController,
          onChanged: (String ) {  } ,):SizedBox(),
        rolls==true?   TextFieldProfile(
          myHintText: 'Department',
          placeHolder: 'Department',
          textFieldStatus:false,
          Textfieldcontroller:_departmentController,
          onChanged: (String ) {  } ,):SizedBox(),
        roll=='STUDENT'? TextFieldProfile(
          myHintText: 'Date Of Birth ',
          placeHolder: 'Date Of Birth',
          textFieldStatus:false,
          Textfieldcontroller:_doBurlController,
          onChanged: (String ) {  } ,):SizedBox(),
        SizedBox(height: 20,),

        // Container(
        //   height:50,width: 150,
        //     child:
        //     customNextButton(onPressed: (){}, buttonName: 'save', buttonColor: true))



      ],),) ,
    );
  }
}

class TextFieldProfile extends StatefulWidget {
  Function(String) onChanged;
  late String myHintText;
  String placeHolder;
  String? helperText;
  String ?Validate;
  final GestureTapCallback? onPressed;
  final TextEditingController Textfieldcontroller;
  bool textFieldStatus;
  TextInputType? KeyboardType;
  bool? showCursor;
  int? maxLength;


  TextFieldProfile({
    Key? key,


    required this.myHintText,
    required this.onChanged,
    required this.placeHolder,
    required this.textFieldStatus,
    this.KeyboardType,
    required this.Textfieldcontroller,
    this.onPressed,
    this.showCursor,
    this.maxLength,
    this.Validate,
    this.helperText,

  }) : super(key: key);

  @override
  State<TextFieldProfile> createState() => _TextFieldProfileState();
}

class _TextFieldProfileState extends State<TextFieldProfile> {
  bool onFocused = false;
  final colors = [
    Color.fromARGB(255, 26, 118, 210),
    Color.fromARGB(50, 221, 239, 253),
    Color.fromARGB(1, 255, 255, 255)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(left: 17),
            child: Text(
              widget.myHintText,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.textFieldStatus == true
                          ? Colors.blueAccent
                          : Colors.white,
                      width: widget.textFieldStatus == true ? 1.3 : 0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color.fromARGB(35, 22, 99, 174)),
              child: TextField(
                maxLength: widget.maxLength,
                onChanged: widget.onChanged,
                controller: widget.Textfieldcontroller,
                enabled: widget.textFieldStatus,
                onTap: widget.onPressed,
                keyboardType: widget.KeyboardType,
                showCursor: widget.showCursor,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    helperText: widget.helperText,
                    helperStyle: TextStyle(color: Colors.red),
                    counterText: '',
                    hintText: widget.placeHolder,
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none),
              )),
        ],
      ),
    );
  }
}