import 'package:flutter/material.dart';
class Tiles extends StatefulWidget {
  String text;
  final IconData icon;
  final GestureTapCallback onPressed;
  Tiles({Key? key, required this.icon,required this.text,required this.onPressed}) : super(key: key);

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: InkWell(onTap:widget.onPressed,splashColor: Colors.white,
          child:  ListTile(
            tileColor: Colors.orange,
            title: Text(widget.text),leading: Icon(widget.icon),)),
    );
  }
}