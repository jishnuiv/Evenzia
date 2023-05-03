import 'package:flutter/material.dart';

import 'myColor.dart';


class NotificationLists extends StatefulWidget {

  String date;
  String message;
  String remark;



  NotificationLists({Key? key,

    required this.message,
    required this.remark,
    required this.date,
  }) : super(key: key);

  @override
  State<NotificationLists> createState() => _NotificationListsState();
}

class _NotificationListsState extends State<NotificationLists> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            width: 300
            ,color:
          Colors.orange.shade300,

            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Date:${widget.date}'),
                          ],
                        ),
                      ),

                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Name:${widget.message}'),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Amount:${widget.remark}'),
                        ],
                      ),

                    ],
                  ),
                ),



              ],

            ),

          ),
        ],
      ),
    );
  }
}


class CustomCard extends StatelessWidget {
  bool Stat;
  String? title;
  String  date;
  String description;
  String organizerId;
  String id;
  String type;
  String organizerName;
  String eventNAme;
  final GestureTapCallback? onPressed;
  CustomCard({Key? key,
    this.onPressed,
    required this.eventNAme,
    required this.Stat,
    required this.date,
   this.title,
    required this.description,
    required this.organizerId,
    required this.organizerName,
    required this.id,
    required this.type,


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
          colors: tileColors
      )
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
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('${eventNAme}:',style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500)),
                  // Text(title,style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500))
                ],),
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
            SizedBox(height: 10,)

          ],),
        ),
      ),
    );
  }
}