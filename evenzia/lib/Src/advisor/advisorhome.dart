import 'package:evenzia/Src/advisor/viewEvents.dart';
import 'package:evenzia/Src/advisor/viewNotification.dart';
import 'package:flutter/material.dart';
import '../../Authentication/selectRoll.dart';
import '../../constant/drawerTile.dart';
import '../../constant/homeTile.dart';
import '../../constant/myColor.dart';
import '../../profile/profile.dart';
import '../dep_rep/generateReport.dart';
import '../secretory/createCertificate.dart';
import '../student/viewfeedback.dart';
import 'addNotification.dart';
import 'eventListForResultupload.dart';
class AdvisorHome extends StatefulWidget {
  const AdvisorHome({Key? key}) : super(key: key);

  @override
  State<AdvisorHome> createState() => _AdvisorHomeState();
}

class _AdvisorHomeState extends State<AdvisorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Advisor'),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile (Url: 'advisor/get-profile')));

            }),
            Tiles(text: 'View Notification', icon:Icons.notifications_active_outlined, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewNotification(uri:'advisor/notifications',)));
            }),
            Tiles(text: 'View Events', icon:Icons.notifications_active_outlined, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>viewEvents(eventUrl: 'advisor/events',)  ));
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

              MyTile(title: 'Add Notifications', onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddAdvisorNotification (Uri: 'advisor/notifications',)));


              },
                imageUrl: 'https://img.icons8.com/arcade/2x/alarm.png',
              ),
              // MyTile(title: ' Events', onPressed: () {
              //    Navigator.push(context, MaterialPageRoute(builder: (context) =>   viewEvents(eventUrl: 'advisor/events',)));
              //
              // },
              //   imageUrl: 'https://cdn-icons-png.flaticon.com/128/2940/2940648.png',
              // ),
              MyTile(title: 'Add Results', onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     EventListViews( EventList: 'advisor/events', roll: '1',)));


              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/9470/9470064.png',
              ),
              MyTile(title: 'Certificates',      onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>     filePic(
                   viewEventUrl: 'advisor/events',
                   submitFileUrl: 'advisor/add-certificate',
                   viewListUrl: 'advisor/participated-students',
                 )));
              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/3000/3000763.png',
              ),
              MyTile(title: 'View Feedback',      onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => viewFeedback (uri: 'student/feedbacks',)));

              },
                imageUrl: 'https://tse2.mm.bing.net/th?id=OIP.cptvfDW20mmpA5sqqSuioQHaGq&pid=Api&P=0',
              ),
              MyTile(title: 'Report',
                imageUrl: 'https://tse4.mm.bing.net/th?id=OIP.JwbjyXSdhOHAGvh_lPzdaAHaHa&pid=Api&P=0',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  GenerateReport(reportUrl:'department-rep/generate-report',)));


                },),
              MyTile(title: 'Add Events', onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>   viewEvents(eventUrl: 'advisor/events',)));

              },
                imageUrl: 'https://tse1.mm.bing.net/th?id=OIP.A2u4G9XhvLrbQJYcK5naxwAAAA&pid=Api&rs=1&c=1&qlt=95&w=120&h=120',
              ),

            ],
          )),);
  }
}
