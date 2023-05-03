import 'package:flutter/material.dart';

import 'myColor.dart';
class MyTile extends StatelessWidget {
  String title;
  String? imageUrl;
  final IconData? icons;
  final GestureTapCallback onPressed;

  MyTile({Key? key,required this.title, required this.onPressed, this.icons,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration:   BoxDecoration( gradient:
      LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:tileColors)
        ,borderRadius:BorderRadius.all(Radius.circular(10)),
      ),
      child: RawMaterialButton(
        splashColor: Colors.white,
        onPressed:onPressed,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Icon(icons)
              SizedBox(height: 30
                ,),
              Container(height: 50 ,width: 50,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl.toString()))),)
            ],
          ),
        ),
      ),
    );
  }
}