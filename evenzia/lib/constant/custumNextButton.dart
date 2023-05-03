import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class customNextButton extends StatelessWidget {
  customNextButton(
      {required this.onPressed,required this.buttonName,required this.buttonColor})
  {

  }
  final GestureTapCallback onPressed;
  String buttonName;
  bool buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:48,
      width:400,
      decoration: BoxDecoration(

          gradient:LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:

            buttonColor?  <Color>[


            Colors.blueAccent,Colors.blue

            ]: [

              Colors.black26,
              Colors.black26,
              Colors.black26,



            ],
          ) ,
          borderRadius: BorderRadius.circular(16)),
      child: RawMaterialButton(


        splashColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(buttonName,style: TextStyle(color: Colors.white,fontSize: 17),)
        ),
        onPressed: onPressed,

      ),
    );
  }
}
