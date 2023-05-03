import 'package:evenzia/Src/dep_rep/practice_request.dart';
import 'package:evenzia/Src/dep_rep/results.dart';
import 'package:flutter/material.dart';
import 'package:evenzia/constant/drawerTile.dart';
import 'package:evenzia/constant/myColor.dart';
import 'package:evenzia/profile/profile.dart';

import '../../Authentication/selectRoll.dart';
import '../../constant/homeTile.dart';
import '../advisor/viewNotification.dart';
import 'approveRequest.dart';
import 'generateReport.dart';
class DepRepHome extends StatefulWidget {
  const DepRepHome({Key? key}) : super(key: key);

  @override
  State<DepRepHome> createState() => _DepRepHomeState();
}

class _DepRepHomeState extends State<DepRepHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Department_Rep'),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Tiles(text: 'Profile', icon:Icons.person, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile (Url: 'department-rep/get-profile')));

            }),

            Tiles(text: 'LogOut', icon:Icons.help_outline, onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectRoll( )));

            }),

          ],
        ),
      ),
      body: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[

              MyTile(title: 'Notifications', onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNotification  (uri: 'department-rep/notifications',)));


              },
                imageUrl: 'https://img.icons8.com/arcade/2x/alarm.png',
              ),
              MyTile(title: 'Request', onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const  ApproveRequest()));

              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/2940/2940648.png',
              ),
              MyTile(title: 'Results', onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>   Results()));


              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/9470/9470064.png',
              ),
              MyTile(title: 'Practice Request', onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>   DepPracticeRequest()));


              },
                imageUrl: 'https://e7.pngegg.com/pngimages/285/615/png-clipart-contemporary-dance-art-music-folk-dance-others-miscellaneous-text.png',
              ),

              MyTile(title: 'Report',
                imageUrl: 'https://tse4.mm.bing.net/th?id=OIP.JwbjyXSdhOHAGvh_lPzdaAHaHa&pid=Api&P=0',
                onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) =>  GenerateReport(reportUrl: 'department-rep/generate-report',)));


              },)
            ],
          )),);
  }
}
