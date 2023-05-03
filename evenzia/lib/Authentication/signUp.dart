
import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/custumNextButton.dart';
import '../constant/urlConstant.dart';

class SignUp extends StatefulWidget {
  String typeUser;
  String Url;
   SignUp({Key? key,
     required this.typeUser,
     required this.Url,
   }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? selectedAnswer;
  File? imageFile;
  bool _buttonColor =false;
  bool EmailState=false;
  bool passwordState=false;
  bool nameState=false;
  bool confirmPasswordState=false;
  String _errorEmail ='';
  String _errorPassword ='';
  String _errorName ='';
  String _errorConfirmPassword ='';
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _departmentIdController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _genController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure1 = true;
  // String? selectedAnswer;
  // String? loginUrl=UrlConst +'${widget.Url}'

  // String? loginUrl1=UrlConst+'media/register';

  Future saveUserData(usreid,username,myPhoneNumber,address,dob,gender,dname) async {
    print('savedatacall');

    print('${username} savedata');

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    return await {

      sharedPreferences.setString('usreid', usreid),
      sharedPreferences.setString('username', username),
      sharedPreferences.setString('myPhoneNumber', myPhoneNumber),
      sharedPreferences.setString('address', address),
      sharedPreferences.setString('dob', dob),
      sharedPreferences.setString('gender', gender),
      sharedPreferences.setString('dname', dname),

    };



  }








  Future<void> signUp(BuildContext ctx) async {

    var map = new Map<String, dynamic>();
    map['name'] = _userNameController.text;
    map['email'] = _emailController.text;
    map['password'] = _passwordController.text;
  widget.typeUser=='3' ? map['department_id'] =_departmentIdController.text:null;
  widget.typeUser=='1' ? map['department'] =_departmentIdController.text:null;
  widget.typeUser=='1' ? map['mobile'] = _mobileController.text:null;
  widget.typeUser=='1' ? map['age'] = _ageController.text:null;
  widget.typeUser=='1' ? map['dob'] =_dateController.text.toString():null;
  widget.typeUser=='1' ? map['gender'] = _genController.text:null;



var file=new Map<String,File>();

    print({'signup',map});
    final response = await http.post(
        Uri.parse(
            UrlConst+widget.Url
        ),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Accept':'application/json',
        },
        body:map
        );
    var jsondata=jsonDecode(response.body);
         print({'resp',jsondata});


    if(jsondata['success'] == true){
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





      });

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => (OrganisationHome())));

    }

    else{
      // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      //     behavior: SnackBarBehavior.fixed,
      //
      //     content: Text( 'Authentication Failed')));

      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
          behavior: SnackBarBehavior.fixed,

          content: Text( 'Incorrect Email or Password'))
      );

    }

  }
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> getPerformerlist(BuildContext ctx) async {
    final response = await http.get(
      Uri.parse(UrlConst+'student/get-register'),
      headers: {
        'Content-Type':'application/json',
      },
    );
    var jsondata=jsonDecode(response.body);
    print(jsondata['status']);

    var status = jsonDecode(response.body)["status_code"].toString();
    var data = jsonDecode(response.body);
    print({"Response Lists: ",data});
    print(data);
    return data;

  }



@override
  void initState() {
  getPerformerlist(context);
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    SizedBox space = SizedBox(height: 10,);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,width: width,
          child: Column(

            children: [
              SizedBox(height: 50,),
              Column(
                children: [
                  Container(
                    height: 200,width: 280,
                    decoration: const BoxDecoration(
                        image:
                        DecorationImage(
                            image: NetworkImage(logo), fit: BoxFit.fill)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
                      space,
                    ],),
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Evenzia',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                      ),
                      SizedBox(width: 10,),
                      Text('Sign up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.blueAccent),),

                    ],
                  ),


                ],
              ),



              Expanded(
                child: ListView(children: [








                  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right: 20),
                    child: TextField(
                      controller: _userNameController,
                      onChanged: (name) {
                        setState(() {

                        });
                        print(name );
                        Validation1(name,'Name');
                      },
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        helperText: _errorName,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),




                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right:20),
                    child: TextField(
                      onChanged: (email) {
                        setState(() {

                        });
                        print( email);
                        Validation1(email,'Email');
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5,left: 25,right: 20),
                    child: TextField(
                      obscureText: _isObscure,
                      onChanged: (password){
                        setState(() {

                          Validation1(password,'Password');
                        });
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        helperText: _errorPassword,
                        helperStyle: TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(

                            _isObscure ? Icons.visibility : Icons.visibility_off_outlined,size: 20,
                            color:Colors.blueAccent,
                          ),
                          onPressed: (){
                            setState(() {
                              _isObscure = !_isObscure;
                            });

                          },
                        ),
                      ),
                    ),
                  ),

                Padding(
                    padding: const EdgeInsets.only(top: 5,left:25,right: 20),
                    child:
                    widget.typeUser=='3' ?
                    // TextField(
                    //   obscureText: false,
                    //   onChanged: (confirmPassword){
                    //     setState(() {
                    //
                    //       // Validation1(confirmPassword,'ConfirmPassword');
                    //     });
                    //   },
                    //
                    //   controller: _departmentIdController,
                    //   decoration: InputDecoration(
                    //     hintText: 'Department d',
                    //     labelText: 'Department Id',
                    //     labelStyle: TextStyle(color: Colors.grey),
                    //     helperText: _errorConfirmPassword,
                    //     helperStyle: TextStyle(color: Colors.red),
                    //
                    //   ),
                    // )
                    TextField(
                      onTap: () {
                        print('test');
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Departments"),
                            content: Container(height:150 ,width: 100,
                              child: FutureBuilder(future:getPerformerlist(context) ,
                                  builder:(BuildContext context, AsyncSnapshot snapshot){
                                    // print(snapshot.data);
                                    if (!snapshot.hasData) {
                                      print(snapshot.error);
                                      return Center(child: CircularProgressIndicator());
                                    }

                                    else{
                                      return ListView.builder(
                                          itemCount:
                                          snapshot.data['departments'].length,
                                          itemBuilder: (BuildContext context, int index) {
                                            print({"SNAPshot:",snapshot.data['success']});
                                            return InkWell(
                                              onTap: (){
                                                setState(() {
                                                  _departmentIdController.text=snapshot.data['departments'][index]['id'].toString();
                                                });


                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: ListTile(

                                                  // trailing: Text('Id:${snapshot.data['departments'][index]['id']}'),
                                                  title: Text('${snapshot.data['departments'][index]['name']}',),
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
                                  child: const Text("Cancel",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        );







                        // Validation1(email,'Email');
                      },
                      controller: _departmentIdController,
                      decoration: const InputDecoration(
                        hintText: 'Department',
                        labelText: 'Department',
                        labelStyle: TextStyle(color: Colors.grey),
                        // helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    )

                    :
                    widget.typeUser=='2' ?
    //                 RaisedButton(
    //            color: Colors.greenAccent,
    //            onPressed: () {
    //            _getFromGallery();
    // },
    //   child: Text("PICK FROM GALLERY"),
    // )
                    SizedBox()
                        :

                    widget.typeUser=='1'?

                    TextField(
                      onChanged: (email) {
                        setState(() {

                        });
                        print( email);
                        // Validation1(email,'Email');
                      },
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintText: 'Age',
                        labelText: 'Age',
                        labelStyle: TextStyle(color: Colors.grey),
                        helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ) :SizedBox(),
                  ),
                  widget.typeUser=='1'?
                  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right:20),
                    child:




                    TextField(
                      onTap: () {
 print('test');
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Departments"),
                              content: Container(height:150 ,width: 100,
                                child: FutureBuilder(future:getPerformerlist(context) ,
                                    builder:(BuildContext context, AsyncSnapshot snapshot){
                                      // print(snapshot.data);
                                      if (!snapshot.hasData) {
                                        print(snapshot.error);
                                        return Center(child: CircularProgressIndicator());
                                      }

                                      else{
                                        return ListView.builder(
                                            itemCount:
                                            snapshot.data['departments'].length,
                                            itemBuilder: (BuildContext context, int index) {
                                              print({"SNAPshot:",snapshot.data['success']});
                                              return InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    _departmentIdController.text=snapshot.data['departments'][index]['id'].toString();
                                                  });


                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: ListTile(

                                                    // trailing: Text('Id:${snapshot.data['departments'][index]['id']}'),
                                                    title: Text('${snapshot.data['departments'][index]['name']}',),
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
                                    child: const Text("Cancel",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          );







                        // Validation1(email,'Email');
                      },
                      controller: _departmentIdController,
                      decoration: const InputDecoration(
                        hintText: 'Department',
                        labelText: 'Department',
                        labelStyle: TextStyle(color: Colors.grey),
                        // helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ):SizedBox(),

                  widget.typeUser=='1'?  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right:20),
                    child: TextField(
                      onChanged: (email) {
                        setState(() {

                        });
                        print( email);
                        // Validation1(email,'Email');
                      },
                      controller: _mobileController,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                        labelText: 'Mobile',
                        labelStyle: TextStyle(color: Colors.grey),
                        // helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ):SizedBox(),





                  widget.typeUser=='1'?  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right:20),
                    child: TextField(
                      onChanged: (email) {
                        setState(() {

                        });
                        print( email);

                      },
                      controller: _dateController,
                      decoration: const InputDecoration(
                        hintText: 'Pick your Date Of Birth',
                        labelText: 'Pick your Date Of Birth',
                        labelStyle: TextStyle(color: Colors.grey),
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                        onTap: () async {
                              var date =  await showDatePicker(
                                  context: context,
                                  initialDate:DateTime.now(),
                                  firstDate:DateTime(1900),
                                  lastDate: DateTime(2100));
                              _dateController.text=date.toString().substring(0,10);
                              print(_dateController.text);
                            },
                    ),


                  ):SizedBox(),


                  widget.typeUser=='1'?  Padding(
                    padding: const EdgeInsets.only(top:5,left:25,right:20),
                    child: TextField(
                      onTap: () {
                        print('test');
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Gender"),
                            content: Container(height:150 ,width: 100,
                              child: FutureBuilder(future:getPerformerlist(context) ,
                                  builder:(BuildContext context, AsyncSnapshot snapshot){
                                    // print(snapshot.data);
                                    if (!snapshot.hasData) {
                                      print(snapshot.error);
                                      return Center(child: CircularProgressIndicator());
                                    }

                                    else{
                                      return ListView.builder(
                                          itemCount: snapshot.data['genders'].length,
                                          itemBuilder: (BuildContext context, int index) {
                                            print({"SNAPshot:",snapshot.data['success']});
                                            return InkWell(
                                              onTap: (){
                                                setState(() {
                                                  _genController.text=snapshot.data['genders'][index]['id'].toString();
                                                });


                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: ListTile(

                                                  // trailing: Text('Id:${snapshot.data['departments'][index]['id']}'),
                                                  title: Text('${snapshot.data['genders'][index]['gender']}',),
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
                                  child: const Text("Cancel",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        );







                        // Validation1(email,'Email');
                      },
                      controller: _genController,
                      decoration: const InputDecoration(
                        hintText: 'Gender',
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.grey),
                        // helperText: _errorEmail,
                        helperStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ):SizedBox(),


                  space,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: customNextButton(buttonName: 'Sign up', onPressed: () {
                      signUp(context);

                      // Validation(_Username,_Email,_Password,_ConfPassword,);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()),);

                    },buttonColor:true),
                  ),

                  space,



                  space,

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",style: TextStyle(color: Colors.grey,fontSize: 15),),
                      InkWell(onTap:(){ Navigator.pop(context);} ,child: Text(" Log in",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 15),)),
                    ],
                  ),
                  space,
                  space,
                  space,
                ],),
              )



            ],

          ),
        ));
  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }







  void Validation1 (String  value,type){

    if(type=='Name') {
      if (value.isEmpty) {
        setState(() {
          // _errorName = "Name can not be empty";

          nameState=false;


        });
      } else if (value.length < 3) {
        setState(() {
          // _errorName = "At least 3 or more characters required";
          nameState=false;

        });
      } else {
        setState(() {

          nameState=true;
          _errorName ='';


        });
      }
    }
    else if(type=='Password') {
      if (value.isEmpty) {
        setState(() {
          // _errorPassword = "Password can not be empty";

          passwordState=false;

        });
      } else if (value.length < 6) {
        setState(() {
          // _errorPassword = "At least 6 or more characters required";
          passwordState=false;
        });
      } else {
        setState(() {

          passwordState=true;

          _errorPassword = "";
        });
      }
    }else if(type=='ConfirmPassword') {
      if (value.isEmpty) {
        setState(() {
          // _errorConfirmPassword = "Password can not be empty";

          confirmPasswordState=false;

        });
      } else if (value.length < 6) {
        setState(() {
          // _errorConfirmPassword = "At least 6 or more characters required";
          confirmPasswordState=false;
        });
      } else {
        setState(() {

          confirmPasswordState=true;
          _errorConfirmPassword ='';
        });
      }
    }
    else if(type=="Email") {
      if (value.isEmpty) {
        setState(() {
          // _errorEmail = "Email can not be empty";
          EmailState=false;
        });
      } else if (!EmailValidator.validate(value, true)) {
        print('value inside the email validation>>>'+value);
        setState(() {
          // _errorEmail = "Invalid Email Address";
          EmailState=false;
        });
      }else{
        setState(() {
          _errorEmail="";
          EmailState=true;


        });
      }
    }



    if(EmailState==true && passwordState==true  && nameState==true){
      // Signup(context);
      _buttonColor = true;
    }
    else{
      _buttonColor= false;
    }


  }

  void Validation (String name ,Email,Pass,confPass,)async {
    if(name.isEmpty){
      setState(() {
        _errorName="Full Name cannot be Empty";
        nameState=false;
      });
    }else if(name.length<3){
      setState(() {
        _errorName="Full Name must be greater than 3 letters";
        nameState=false;
      });
    }else{
      _errorName="";
      nameState=true;
    }
    if(Email.isEmpty){
      setState(() {
        _errorEmail="Email cannot be empty";
        EmailState=false;
      });
    } else if(Email.contains("@") && Email.contains(".") && EmailValidator.validate(Email, true)){
      setState(() {
        _errorEmail="";
        EmailState=true;
      });
    } else {
      setState(() {
        _errorEmail="Enter a valid Email id";
        EmailState=false;
      });
    }
    if(Pass.isEmpty){
      setState(() {
        _errorPassword="Password cannot be empty";
        passwordState=true;
      });
    }else if(Pass.length<6){
      setState(() {
        _errorPassword="Enter a valid password";
        passwordState=false;
      });
    }else{
      _errorPassword="";
      passwordState=true;
    }

    if(nameState==true&&EmailState==true&&passwordState==true&&confirmPasswordState==true){

    }else{
      print(nameState);
      print(EmailState);
      print(passwordState);
      print(confirmPasswordState);
    }
  }
}

